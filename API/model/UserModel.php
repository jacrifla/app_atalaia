<?php

// require '../core/ConnectionMYSQL.php';
// require '../core/ExceptionPdo.php';

class UserModel{

    // public static function show(){
    //     try{
    //         $pdo = ConnectionMYSQL::getInstance();
    //         $stmt = $pdo->prepare('SELECT * FROM tb_user ORDER BY codigo');
    //         $stmt->execute();

    //         return $stmt->fetchAll(PDO::FETCH_OBJ);
    //     }catch(\PDOException $e){
    //         throw new \Exception(ExceptionPdo::translateError($e->getMessage()));
    //     }catch(\Exception $e){
    //         throw new \Exception($e->getMessage());
    //     }
    // }

    public static function find(int $code){
        try{
            $pdo = ConnectionMYSQL::getInstance();
            $stmt = $pdo->prepare('SELECT * FROM tb_user ORDER BY codigo = ?');
            // o ? é um meio de parametrizar e evitar sql injections, não é seguro concatenar
            //ele saberá qual variável está sendo utilizada pois é passada no metodo execute como parametro
            $stmt->execute([$code]);

            return $stmt->fetchAll(PDO::FETCH_OBJ);
        }catch(\PDOException $e){
            throw new \Exception(ExceptionPdo::translateError($e->getMessage()));
        }catch(\Exception $e){
            throw new \Exception($e->getMessage());
        }

    }

    public static function insert(array $data){

        try{
            $pdo = ConnectionMYSQL::getInstance();
            $stmt = $pdo->prepare('INSERT INTO tb_user (descricao, valor) VALUES(?,?)');
            // o ? é um meio de parametrizar e evitar sql injections, não é seguro concatenar
            //ele saberá qual variável está sendo utilizada pois é passada no metodo execute como parametro
            $stmt->execute([$data['descricao'], $data['valor']]);

            return ($stmt->rowCount() > 0);
        }catch(\PDOException $e){
            throw new \Exception(ExceptionPdo::translateError($e->getMessage()));
        }catch(\Exception $e){
            throw new \Exception($e->getMessage());
        }
    }

    public static function update(array $data){

        try{
            $pdo = ConnectionMYSQL::getInstance();
            $stmt = $pdo->prepare('UPDATE tb_user SET descricao = ?, valor = ? WHERE codigo = ?');
            // o ? é um meio de parametrizar e evitar sql injections, não é seguro concatenar
            //ele saberá qual variável está sendo utilizada pois é passada no metodo execute como parametro
            $stmt->execute([$data['descricao'], $data['valor'], $data['codigo']]);

            return ($stmt->rowCount() > 0);
        }catch(\PDOException $e){
            throw new \Exception(ExceptionPdo::translateError($e->getMessage()));
        }catch(\Exception $e){
            throw new \Exception($e->getMessage());
        }

    }

    public static function delete(int $code){

        try{
            $pdo = ConnectionMYSQL::getInstance();
            $stmt = $pdo->prepare('DELETE FROM tb_user WHERE codigo = ?');
            // o ? é um meio de parametrizar e evitar sql injections, não é seguro concatenar
            //ele saberá qual variável está sendo utilizada pois é passada no metodo execute como parametro
            $stmt->execute([$code]);

            return $stmt->fetchAll(PDO::FETCH_OBJ);
        }catch(\PDOException $e){
            throw new \Exception(ExceptionPdo::translateError($e->getMessage()));
        }catch(\Exception $e){
            throw new \Exception($e->getMessage());
        }

    }

    public static function lastInsertId(){

        try{
            $pdo = ConnectionMYSQL::getInstance();
            
            return $pdo->lastInsertId();
        }catch(\PDOException $e){
            throw new \Exception(ExceptionPdo::translateError($e->getMessage()));
        }catch(\Exception $e){
            throw new \Exception($e->getMessage());
        }

    }

    


}