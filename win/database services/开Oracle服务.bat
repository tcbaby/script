	@echo.服务启动......
      	@echo off
      	@sc start OracleDBConsoleorcl
      	@sc start OracleJobSchedulerORCL
      	@sc start OracleMTSRecoveryService
      	@sc start OracleOraDb11g_home1ClrAgent
      	@sc start OracleOraDb11g_home1TNSListener
      	@sc start OracleServiceORCL
      	@echo off
      	@echo.启动完毕！
      	@pause