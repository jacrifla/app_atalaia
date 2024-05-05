<?php

require_once './core/Request.php';
require_once './core/Response.php';
require_once './model/LoginModel.php';
require_once './model/UserModel.php';

class LoginController
{
    
    public function login(Request $request, Response $response)
    {
        try {

             // // Verificar se os dados da requisição estão preenchidos corretamente usando o middleware EX
            // AINDA EM IMPLEMENTAÇÃO
            // $validationMiddleware = new Validations();
            // $validationResult = $validationMiddleware($request, $response, function ($request, $response) {
                // return $response;
            // });

            // // Se houver erros de validação, retornar a resposta com os erros
            // if ($validationResult->getStatusCode() !== 200) {
            //     return $validationResult;
            // }

            $data = $request->body();

            $hasUser = UserModel::checkUserExists($data);
            if($hasUser){
                $data = LoginModel::login($data);

                if ($data) :
                    $response::json([
                        'status' => 'success',
                        'dados' => $data
                    ], 200);
                else :
                    $response::json([
                        'status' => 'error',
                        'msg' => 'Credentials failed'
                    ], 401);
                endif;
            }else{
                $response::json([
                    'status' => 'error',
                    'msg' => 'Not found'
                ], 404);
            }
            
        } catch (\Exception $e) {
            $response::json([
                'status' => 'error',
                'msg' => $e->getMessage()
            ], 500);
        }
    }

}
