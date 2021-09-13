
Get-EventLog -LogName Application -Source ActionsRunnerService

Get-Service "actions.runner.octo-org-octo-repo.runner01.service" | Select-Object Name, Status