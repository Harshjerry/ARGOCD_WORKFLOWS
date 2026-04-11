
🔥 Why schedule workflows?
Use cases:
1. Nightly data pipeline
Run every day at 2 AM
2. Backup system
Run every 6 hours
3. Model retraining
Run every week
4. Log cleanup
Run every hour




schedule : "* * * * *"
this decide how often our workflow is trigerred
* * * * *
| | | | |
| | | | └ day of week
| | | └── month
| | └──── day of month
| └────── hour
└──────── minute


✅  suspend: false
If true → pauses the CronWorkflow (no new runs).
If false → active and runs as scheduled


✅ concurrencyPolicy: "Forbid"
Controls what happens if a previous workflow is still running.
Options:
Allow → run multiple workflows concurrently
Forbid →  don’t start new one if previous is still running
Replace → stop old and start new
 You chose Forbid → safe, avoids overlap.


🔹 History Limits
✅ successfulJobsHistoryLimit: 2
Keeps last 2 successful workflows
Older ones are deleted

failedJobsHistoryLimit: 2
Keeps last 2 failed workflows
Helps debugging without clutter

🔥 What is startingDeadlineSeconds?
👉 It defines how long Argo will wait to still run a MISSED schedule
If a job was supposed to run but missed (cluster down / controller down)
Then Argo checks:
“Is it still within allowed delay time?”



# to create CRON WORFLOW
$ argo cron create cron-wf.yaml -n argo
$ argo cron list -n argo 
$ argo cron delete name -n argo 


