import { spawn } from "node:child_process";
import * as path from "node:path";
import type { PostToolUsePayload } from "../../lib";
import { extractFilePath, shouldFormat } from "./utils";

export type FormatResult = {
  success: boolean;
  output: string;
  error: string;
  exitCode: number;
  filePath: string;
};

const ESLINT_EXTENSIONS = new Set([
  ".js",
  ".jsx",
  ".ts",
  ".tsx",
  ".json",
  ".css",
  ".scss",
  ".html",
  ".md",
]);

function formatFile(
  payload: PostToolUsePayload,
  callback: (filePath: string) => Promise<FormatResult>,
) {
  const filePath = extractFilePath(payload);
  if (!filePath) return Promise.resolve(null);

  const ext = path.extname(filePath);
  if (!ESLINT_EXTENSIONS.has(ext)) return Promise.resolve(null);

  return callback(filePath);
}

function runEslint(filePath: string): Promise<FormatResult> {
  return new Promise((resolve) => {
    const child = spawn("npx", ["eslint", "--fix", filePath], {
      stdio: ["pipe", "pipe", "pipe"],
      timeout: 10000,
    });

    let stdout = "";
    let stderr = "";

    child.stdout?.on("data", (data) => {
      stdout += data.toString();
    });

    child.stderr?.on("data", (data) => {
      stderr += data.toString();
    });

    child.on("close", (code) => {
      resolve({
        success: code === 0,
        output: stdout,
        error: stderr,
        exitCode: code || 0,
        filePath,
      });
    });

    child.on("error", (error) => {
      resolve({
        success: false,
        output: "",
        error: error.message,
        exitCode: -1,
        filePath,
      });
    });
  });
}

export async function formatEslint(
  operation: string,
  payload: PostToolUsePayload,
): Promise<void> {
  try {
    if (!shouldFormat(payload)) return;
    const result = await formatFile(payload, runEslint);
    if (!result) return;

    if (result.success) {
      console.log(
        `🎨 [${operation}] Formatted ${path.basename(result.filePath)} with Eslint`,
      );
    } else {
      console.log(
        `⚠️  [${operation}] Failed to format ${path.basename(result.filePath)}: ${result.error}`,
      );
    }
  } catch (error) {
    console.error(
      `❌ [${operation}] Code formatting error: ${error instanceof Error ? error.message : String(error)}`,
    );
  }
}
