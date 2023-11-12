import { createLogger, format, transports } from "winston";

const logger = createLogger({
    transports: [
        new transports.Console(),
        // log incoming requests as informational request 
        new transports.File({
            level: 'info',
            filename: './logs/logTracking/logInfo.log'
        }),
        new transports.File({
            level: 'warn',
            filename: './logs/logTracking/logWarning.log'
        }),
        new transports.File({
            level: 'error',
            filename: './logs/logTracking/logError.log'
        })
    ],
    format: format.combine(
        format.json(),
        format.timestamp(),
        format.simple()
    ),
    statusLevels: true
});

export default logger;
