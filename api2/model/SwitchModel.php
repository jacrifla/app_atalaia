<?php

require_once './core/ConnectionMYSQL.php';
require_once './core/ExceptionPdo.php';

class RegisterModel
{
    public static function getSwitches($userId)
    {
        try {
            $pdo = ConnectionMYSQL::getInstance();

            $stmt = $pdo->prepare('SELECT s.* 
            FROM tb_switch s
            JOIN tb_user u ON s.user_id = u.id
            WHERE u.uuid = ?            
            AND s.deleted_at IS NULL');
            $stmt->execute([$userId]);

            return $stmt->fetchAll(PDO::FETCH_OBJ);
        } catch (\PDOException $e) {
            throw new \Exception(ExceptionPdo::translateError($e->getMessage()));
        } catch (\Exception $e) {
            throw new \Exception($e->getMessage());
        }
    }

    //Atualiza se o switch ta aceso ou apagado
    public static function toggleSwitch($data)
    {
        try {

            $pdo = ConnectionMYSQL::getInstance();
            stmt = $pdo->prepare('UPDATE tb_switch SET is_active = ? WHERE uuid = ?');
            $stmt->execute([$data['is_active'], $data['uuid']]);

            return ($stmt->rowCount() > 0);
        } catch (\PDOException $e) {
            throw new \Exception(ExceptionPdo::translateError($e->getMessage()));
        } catch (\Exception $e) {
            throw new \Exception($e->getMessage());
        }
    }


    public static function checkSwitchExists($mac_address){
        try {
            $pdo = ConnectionMYSQL::getInstance();
    
    
            $stmt = $pdo->prepare('
                SELECT uuid 
                FROM tb_switch 
                WHERE mac_address = ? '
            );
            
            $stmt->execute([$mac_address]);
    
            return $stmt->fetch(PDO::FETCH_ASSOC);
    
        } catch (\PDOException $e) {
            throw new \Exception(ExceptionPdo::translateError($e->getMessage()));
        } catch (\Exception $e) {
            throw new \Exception($e->getMessage());
        }
    }


    public static function createSwitch(array $data)
    {
        try {
            $pdo = ConnectionMYSQL::getInstance();

            $stmt = $pdo->prepare('
            INSERT INTO tb_switch (uuid, name, watts, mac_address) 
            VALUES (UUID(), ?, ?, ?)'
        );

        $stmt->execute([$data['name'], $data['watts'], $data['mac_address']]);

            return ($stmt->rowCount() > 0);
        } catch (\PDOException $e) {
            throw new \Exception(ExceptionPdo::translateError($e->getMessage()));
        } catch (\Exception $e) {
            throw new \Exception($e->getMessage());
        }
    }

    //Caso tente criar um switch novamente após ter deletado (softdelete) 
    public static function reactivateSwitch(array $data){
        try {
            $pdo = ConnectionMYSQL::getInstance();

            stmt = $pdo->prepare('UPDATE tb_switch SET name = ?, watts = ?, deleted_at = NULL WHERE mac_address = ?');
            $stmt->execute([$data['name'], $data['watts'], $data['mac_address']]);

            return ($stmt->rowCount() > 0);
        } catch (\PDOException $e) {
            throw new \Exception(ExceptionPdo::translateError($e->getMessage()));
        } catch (\Exception $e) {
            throw new \Exception($e->getMessage());
        }
    }

    public static function updateSwitchInfo(array $data)
    {
        try {
            $pdo = ConnectionMYSQL::getInstance();

            stmt = $pdo->prepare('UPDATE tb_switch SET name = ?, watts = ? WHERE uuid = ?');
            $stmt->execute([$data['name'], $data['watts'], $data['uuid']]);

            return ($stmt->rowCount() > 0);
        } catch (\PDOException $e) {
            throw new \Exception(ExceptionPdo::translateError($e->getMessage()));
        } catch (\Exception $e) {
            throw new \Exception($e->getMessage());
        }
    }

    public static function softDelete($switchId)
    {
        try {
            $pdo = ConnectionMYSQL::getInstance();
            stmt = $pdo->prepare('UPDATE tb_switch SET deleted_at = CURRENT_TIMESTAMP WHERE uuid = ?');
            $stmt->execute([$switchId]);

            return ($stmt->rowCount() > 0);
        } catch (\PDOException $e) {
            throw new \Exception(ExceptionPdo::translateError($e->getMessage()));
        } catch (\Exception $e) {
            throw new \Exception($e->getMessage());
        }
    }

   
}
