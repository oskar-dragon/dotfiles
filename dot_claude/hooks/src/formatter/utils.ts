import type { PostToolUsePayload } from "../../lib";

export function extractFilePath(payload: PostToolUsePayload): string | null {
  const toolInput = payload.tool_input as any;
  return toolInput?.file_path || toolInput?.filePath || null;
}
const FORMATTABLE_TOOLS = ["Edit", "Write", "MultiEdit"];

export function shouldFormat(payload: PostToolUsePayload): boolean {
  // Only format on Edit, Write, or MultiEdit tools
  return FORMATTABLE_TOOLS.includes(payload.tool_name);
}
