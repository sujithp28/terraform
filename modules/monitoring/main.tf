################################################################################
# SNS Topic for Alerts
################################################################################

resource "aws_sns_topic" "alerts" {
  name = "${var.name}-alerts"
  tags = var.tags
}

resource "aws_sns_topic_subscription" "email" {
  topic_arn = aws_sns_topic.alerts.arn
  protocol  = "email"
  endpoint  = var.alarm_email
}

################################################################################
# CloudWatch Log Groups
################################################################################

resource "aws_cloudwatch_log_group" "application" {
  name              = "/aws/application/${var.name}"
  retention_in_days = var.log_retention_days
  tags              = var.tags
}

################################################################################
# RDS Alarms
################################################################################

resource "aws_cloudwatch_metric_alarm" "rds_cpu" {
  count = var.rds_instance_id != "" ? 1 : 0

  alarm_name          = "${var.name}-rds-cpu-high"
  comparison_operator = "GreaterThanThreshold"
  evaluation_periods  = 2
  metric_name         = "CPUUtilization"
  namespace           = "AWS/RDS"
  period              = 300
  statistic           = "Average"
  threshold           = var.rds_cpu_threshold
  alarm_description   = "RDS CPU utilization exceeded ${var.rds_cpu_threshold}%"
  alarm_actions       = [aws_sns_topic.alerts.arn]
  ok_actions          = [aws_sns_topic.alerts.arn]

  dimensions = {
    DBInstanceIdentifier = var.rds_instance_id
  }

  tags = var.tags
}

resource "aws_cloudwatch_metric_alarm" "rds_storage" {
  count = var.rds_instance_id != "" ? 1 : 0

  alarm_name          = "${var.name}-rds-storage-low"
  comparison_operator = "LessThanThreshold"
  evaluation_periods  = 1
  metric_name         = "FreeStorageSpace"
  namespace           = "AWS/RDS"
  period              = 300
  statistic           = "Average"
  threshold           = var.rds_storage_threshold
  alarm_description   = "RDS free storage below 10 GB"
  alarm_actions       = [aws_sns_topic.alerts.arn]
  ok_actions          = [aws_sns_topic.alerts.arn]

  dimensions = {
    DBInstanceIdentifier = var.rds_instance_id
  }

  tags = var.tags
}

resource "aws_cloudwatch_metric_alarm" "rds_connections" {
  count = var.rds_instance_id != "" ? 1 : 0

  alarm_name          = "${var.name}-rds-connections-high"
  comparison_operator = "GreaterThanThreshold"
  evaluation_periods  = 2
  metric_name         = "DatabaseConnections"
  namespace           = "AWS/RDS"
  period              = 300
  statistic           = "Average"
  threshold           = 200
  alarm_description   = "RDS connection count exceeded 200"
  alarm_actions       = [aws_sns_topic.alerts.arn]

  dimensions = {
    DBInstanceIdentifier = var.rds_instance_id
  }

  tags = var.tags
}

################################################################################
# CloudWatch Dashboard
################################################################################

resource "aws_cloudwatch_dashboard" "main" {
  dashboard_name = "${var.name}-overview"

  dashboard_body = jsonencode({
    widgets = [
      {
        type   = "text"
        x      = 0; y = 0; width = 24; height = 2
        properties = {
          markdown = "## ${var.name} Infrastructure Overview\nLast updated automatically by Terraform."
        }
      },
      var.rds_instance_id != "" ? {
        type   = "metric"
        x      = 0; y = 2; width = 8; height = 6
        properties = {
          title   = "RDS CPU Utilization"
          metrics = [["AWS/RDS", "CPUUtilization", "DBInstanceIdentifier", var.rds_instance_id]]
          period  = 300
          stat    = "Average"
          view    = "timeSeries"
          region  = "us-east-1"
        }
      } : null,
      var.rds_instance_id != "" ? {
        type   = "metric"
        x      = 8; y = 2; width = 8; height = 6
        properties = {
          title   = "RDS Free Storage (bytes)"
          metrics = [["AWS/RDS", "FreeStorageSpace", "DBInstanceIdentifier", var.rds_instance_id]]
          period  = 300
          stat    = "Average"
          view    = "timeSeries"
          region  = "us-east-1"
        }
      } : null,
      var.rds_instance_id != "" ? {
        type   = "metric"
        x      = 16; y = 2; width = 8; height = 6
        properties = {
          title   = "RDS Connections"
          metrics = [["AWS/RDS", "DatabaseConnections", "DBInstanceIdentifier", var.rds_instance_id]]
          period  = 300
          stat    = "Average"
          view    = "timeSeries"
          region  = "us-east-1"
        }
      } : null
    ]
  })
}
