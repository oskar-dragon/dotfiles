import notifier from "node-notifier";

export type NotificationType =
  | "task-completed"
  | "permission-required"
  | "error"
  | "idle";

export type NotificationConfig = {
  title: string;
  message: string;
  sound?: boolean;
  icon?: string;
  timeout?: number;
};

const DEFAULT_SETTINGS = {
  sound: false,
  timeout: 5000,
} as const;

function getBaseConfigForType(type: NotificationType): NotificationConfig {
  switch (type) {
    case "task-completed":
      return {
        title: "Claude Code",
        message: "Task completed successfully",
        sound: DEFAULT_SETTINGS.sound,
        timeout: DEFAULT_SETTINGS.timeout,
      };
    case "permission-required":
      return {
        title: "Claude Code - Permission Required",
        message: "User permission required to continue",
        sound: DEFAULT_SETTINGS.sound,
        timeout: DEFAULT_SETTINGS.timeout,
      };
    case "error":
      return {
        title: "Claude Code - Error",
        message: "An error occurred during execution",
        sound: DEFAULT_SETTINGS.sound,
        timeout: DEFAULT_SETTINGS.timeout,
      };
    case "idle":
      return {
        title: "Claude Code - Idle",
        message: "Session has been idle",
        sound: DEFAULT_SETTINGS.sound,
        timeout: DEFAULT_SETTINGS.timeout,
      };
    default:
      return {
        title: "Claude Code",
        message: "Notification",
        sound: DEFAULT_SETTINGS.sound,
        timeout: DEFAULT_SETTINGS.timeout,
      };
  }
}

function createNotificationConfig(
  type: NotificationType,
  customConfig?: Partial<NotificationConfig>,
): NotificationConfig {
  const baseConfig = getBaseConfigForType(type);
  return { ...baseConfig, ...customConfig };
}

function sendDesktopNotification(config: NotificationConfig): void {
  notifier.notify({
    title: config.title,
    message: config.message,
    sound: config.sound,
    timeout: config.timeout,
    ...(config.icon && { icon: config.icon }),
  });
}

export function notify(
  type: NotificationType,
  customConfig?: Partial<NotificationConfig>,
) {
  const config = createNotificationConfig(type, customConfig);

  sendDesktopNotification(config);
}
