      	@echo.服务启动......
      	@echo off
      	@sc start MSSQLFDLauncher
      	@sc start MSSQLSERVER
      	@sc start MSSQL$SQLEXPRESS
      	@sc start MSSQLServerOLAPService
      	@sc start SQLBrowser
      	@sc start MsDtsServer100
      	@sc start ReportServer
      	@sc start SQLWriter
      	@sc start SQLSERVERAGENT
      	@echo off
      	@echo.启动完毕！
      	@pause