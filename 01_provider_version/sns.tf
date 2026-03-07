resource "aws_sns_topic" "user_updates" {
  name = "user-updates-topic"
}

output "sns_topic_owner" {
  value = aws_sns_topic.user_updates.owner
}