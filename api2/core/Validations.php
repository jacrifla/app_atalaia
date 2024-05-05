<!-- create a middleware for validate required parameters from request -->

<?php

require_once './core/Response.php';

class Validations {
    public function __invoke($request, $response, $next) {
        $parsedBody = $request->getParsedBody();

        if (empty($parsedBody)) {
            return $response::json([
                'status' => 'error',
                'msg' => 'Nenhum dado na requisição'
            ], 400);
        }

        // Validations ex:
        //TO DEVELOP: ALL FIELDS ACCORDING TO ROUTE
        $validations = [
            'nome' => 'required|string|max:255',
            'email' => 'required|email',
            'idade' => 'required|integer|min:18',
            'telefone' => 'required|string|regex:/^\(\d{2}\)\s\d{4,5}-\d{4}$/',
        ];

        
        foreach ($validations as $field => $rules) {
            $rulesArray = explode('|', $rules);

            foreach ($rulesArray as $rule) {
                if ($rule === 'required' && empty($parsedBody[$field])) {
                    return $response->withJson(['status' => 'error', 'msg' => "O campo '$field' é obrigatório."], 400);
                }

                if ($rule === 'string' && isset($parsedBody[$field]) && !is_string($parsedBody[$field])) {
                    return $response->withJson(['status' => 'error', 'msg' => "O campo '$field' deve ser uma string."], 400);
                }

                if ($rule === 'integer' && isset($parsedBody[$field]) && !is_int($parsedBody[$field] + 0)) {
                    return $response->withJson(['status' => 'error', 'msg' => "O campo '$field' deve ser um número inteiro."], 400);
                }

                if ($rule === 'email' && isset($parsedBody[$field]) && !filter_var($parsedBody[$field], FILTER_VALIDATE_EMAIL)) {
                    return $response->withJson(['status' => 'error', 'msg' => "O campo '$field' deve ser um endereço de e-mail válido."], 400);
                }

                if (strpos($rule, 'max:') === 0 && isset($parsedBody[$field]) && strlen($parsedBody[$field]) > intval(substr($rule, 4))) {
                    return $response->withJson(['status' => 'error', 'msg' => "O campo '$field' deve ter no máximo " . intval(substr($rule, 4)) . " caracteres."], 400);
                }

                if (strpos($rule, 'min:') === 0 && isset($parsedBody[$field]) && strlen($parsedBody[$field]) < intval(substr($rule, 4))) {
                    return $response->withJson(['status' => 'error', 'msg' => "O campo '$field' deve ter no mínimo " . intval(substr($rule, 4)) . " caracteres."], 400);
                }

                if (strpos($rule, 'regex:') === 0 && isset($parsedBody[$field]) && !preg_match(substr($rule, 6), $parsedBody[$field])) {
                    return $response->withJson(['status' => 'error', 'msg' => "O campo '$field' não está no formato esperado."], 400);
                }
            }
        }

        return $next($request, $response);
    }
}
