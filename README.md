# Resource-Aware CI/CD Pipeline

Standard CI/CD pipelines blindly execute build jobs regardless of the underlying runner's hardware.
When deploying heavy Docker images or AI inference workloads, this often causes massive Out-Of-Memory (OOM) crashes, burning cloud credits and blocking deployments.

This repository demonstrates a "smart" pipeline that addresses the problem.
It injects a Bash-level pre-flight check into the GitHub Actions workflow, actively querying the cloud runner's Linux kernel (`free -m`, `nproc`) for available CPU and RAM. 

If the runner is under-resourced, the pipeline gracefully aborts the job *before* a catastrophic crash occurs, saving compute time and providing clear telemetry to the DevOps team.
