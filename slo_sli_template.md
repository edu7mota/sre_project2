# API Service

| Category     | SLI                                                                                                 | SLO                                                                                                         |
|--------------|-----------------------------------------------------------------------------------------------------|-------------------------------------------------------------------------------------------------------------|
| Availability | Total number of requests with status code between 200 and 499 divided by total number of requests   | 99%                                                                                                         |
| Latency      | Average handle time of a response from the time in is received to when the response is sent back while the application is running | 90% of requests below 100ms |
| Error Budget | Total number of requests with status code higher than 500 divided by the total number of requests   | Error budget is defined at 20%. This means that 20% of the requests can fail and still be within the budget |
| Throughput   | Total number of requests per minute | 5 RPS indicates the application is functioning |
