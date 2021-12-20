## Availability SLI
### The percentage of successful requests over the last 5m
(avg_over_time((app_http_success_response_count_total[1m])*100)

## Latency SLI
### 90% of requests finish in these times
app_http_response_time_seconds{quantile="0.9",method="GET",status="200"}

## Throughput
### Successful requests per second
sum(app_http_success_response_count_total)

## Error Budget - Remaining Error Budget
### The error budget is 20%
100-(avg_over_time(app_http_success_response_count_total[1m])*100)
