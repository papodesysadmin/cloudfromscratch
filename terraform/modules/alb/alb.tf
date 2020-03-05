resource "aws_alb" "app_alb" { 
    name                = "app-alb"
    subnets             = [
                            var.subnetid,
                            var.subnetid_2
                        ]
    enable_deletion_protection = true
    security_groups = [var.securitygroup_id]
    idle_timeout    = 600

    tags = {
        Name            = "app_alb"
        Organization    = "Papo de Sysadmin"
    }
}

resource "aws_alb_target_group" "apps_target_group" {
    name        = "apps-target-group"
    port        = "80"
    protocol    = "HTTP"
    vpc_id      = var.vpcid
    target_type = "instance"

    lifecycle { create_before_destroy = true }

    health_check {
        healthy_threshold   = 3
        unhealthy_threshold = 10
        timeout             = 5
        interval            = 10
        matcher             = "200"
        path                = "/healthcheck"
        port                = "80"
    } 

    depends_on  = [aws_alb.app_alb]

    tags = {
        Organization = "Papo de sysadmin"
    }
}

resource "aws_alb_listener" "web_app"{

    load_balancer_arn   = aws_alb.app_alb.arn
    port                = "80"
    depends_on          = [aws_alb_target_group.apps_target_group]

    default_action {
        target_group_arn  = aws_alb_target_group.apps_target_group.arn
        type              = "forward"
    }
}

resource "aws_lb_target_group_attachment" "attach_ec2" {
    target_group_arn    = aws_alb_target_group.apps_target_group.arn
    target_id           = var.instance_id
    port                = 80
}
