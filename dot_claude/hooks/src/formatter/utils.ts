import type { PostToolUsePayload } from "../../lib";

export function extractFilePath(payload: PostToolUsePayload): string | null {
  const toolInput = payload.tool_input as any;
  return toolInput?.file_path || toolInput?.filePath || null;
}

export function shouldFormat(payload: PostToolUsePayload): boolean {
  // Only format on Edit, Write, or MultiEdit tools
  return /^(Edit|Write|MultiEdit)$/.test(payload.tool_name);
}
