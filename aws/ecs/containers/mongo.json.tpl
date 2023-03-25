[{
	"name": "${app_name}",
	"image": "${app_image}",
	"cpu": ${fargate_cpu},
	"memory": ${fargate_memory},
	"networkMode": "awsvpc",
	"taskRoleArn": "task_role",
	"environment": [{
			"name": "MONGO_INITDB_ROOT_USERNAME",
			"value": "user"
		},
		{
			"name": "MONGO_INITDB_ROOT_PASSWORD",
			"value": "password"
		},
		{
			"name": "MONGO_INITDB_DATABASE",
			"value": "videos"
		}			
	],	
	"portMappings": [{
		"containerPort": ${app_port},
		"hostPort": ${app_port}
	}],
	"logConfiguration": {
		"logDriver": "awslogs",
		"options": {
			"awslogs-group": "${cloudwatch_group}",
			"awslogs-region": "${aws_region}",
			"awslogs-stream-prefix": "streaming"
		}
	}
}]
