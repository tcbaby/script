	@echo.服务启动......
      	@echo off
      	@sc stop OracleDBConsoleorcl
      	@sc stop OracleJobSchedulerORCL
      	@sc stop OracleMTSRecoveryService
      	@sc stop OracleOraDb11g_home1ClrAgent
      	@sc stop OracleOraDb11g_home1TNSListener
      	@sc stop OracleServiceORCL
      	@echo off
      	@echo.启动完毕！
      	@pause