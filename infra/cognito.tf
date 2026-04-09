resource "aws_ssm_parameter" "user_pool_id"{
    name = "/app/cognito/user_pool_id"
    type = "String"
    value = aws_cognito_user_pool.xpix_pool.id
    overwrite = true

}

import{
    to = aws_ssm_parameter.user_pool_id
    id = "/app/cognito/user_pool_id"
}

resource "aws_ssm_parameter" "client_id"{
    name = "/app/cognito/client_id"
    type = "String"
    value = aws_cognito_user_pool_client.xpix_client.id
    overwrite = true
}

import{
    to = aws_ssm_parameter.client_id
    id = "/app/cognito/client_id"
}