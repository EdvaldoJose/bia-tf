resource "aws_ecs_capacity_provider" "bia-tf" {
  name = "cluster-bia-tf"

  auto_scaling_group_provider {
    auto_scaling_group_arn = aws_autoscaling_group.ecs.arn
    managed_termination_protection = "DISABLED"

    managed_scaling {
      maximum_scaling_step_size = 2
      minimum_scaling_step_size = 1
      status                    = "ENABLED"
      target_capacity           = 100
    }
  }
}

resource "aws_ecs_cluster_capacity_providers" "main" {
  cluster_name = aws_ecs_cluster.cluster-bia-tf.name
  capacity_providers = [aws_ecs_capacity_provider.bia-tf.name]

  default_capacity_provider_strategy {
    capacity_provider = aws_ecs_capacity_provider.bia-tf.name
    base              = 1
    weight            = 100
  }
}