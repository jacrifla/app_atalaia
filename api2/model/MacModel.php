<?php

require_once './core/ConnectionMYSQL.php';
require_once './core/ExceptionPdo.php';

class MacModel
{
    
   
    //checa se o endereço mac enviado pelo usuario existe na base de mac disponiveis ou se nao está em uso (serve para caso o mac seja digitado erroneamente)
    public static function checkMacAddressAvailable($mac_address){
        try {
            $pdo = ConnectionMYSQL::getInstance();
    
    
            $stmt = $pdo->prepare('
                SELECT id, is_used 
                FROM tb_mac_address 
                WHERE mac_address = ? '
            );
            
            $stmt->execute([$mac_address]);
    
            $mac_record = $stmt->fetch(PDO::FETCH_ASSOC);

            if(($stmt->rowCount() <= 0) || $mac_record['is_used'] ){
                return null;
            }

            return $mac_record;
        } catch (\PDOException $e) {
            throw new \Exception(ExceptionPdo::translateError($e->getMessage()));
        } catch (\Exception $e) {
            throw new \Exception($e->getMessage());
        }
    }

    //Quando um switch é criado atualiza na tabela de mac addresses que esse mac foi colocado em uso por algum usuario
    public static function updateMacAddressRecord($mac_address)
    {
        try {
            $pdo = ConnectionMYSQL::getInstance();

            $stmt = $pdo->prepare('UPDATE tb_mac_address SET is_used = true WHERE mac_address = ?');
            $stmt->execute([$mac_address]);

            return ($stmt->rowCount() > 0);
        } catch (\PDOException $e) {
            throw new \Exception(ExceptionPdo::translateError($e->getMessage()));
        } catch (\Exception $e) {
            throw new \Exception($e->getMessage());
        }
    }

    //USO INTERNO
    public static function insert($mac_address){
        try {
            $pdo = ConnectionMYSQL::getInstance();

            $stmt = $pdo->prepare('
            INSERT INTO tb_mac_address (mac_address) 
            VALUES (?)'
        );

        $stmt->execute([$mac_address]);

            return ($stmt->rowCount() > 0);
        } catch (\PDOException $e) {
            throw new \Exception(ExceptionPdo::translateError($e->getMessage()));
        } catch (\Exception $e) {
            throw new \Exception($e->getMessage());
        }

    }

    //USO INTERNO
    public static function delete($id){
        try {
            $pdo = ConnectionMYSQL::getInstance();
    
            $stmt = $pdo->prepare('
                DELETE FROM tb_mac_address 
                WHERE id = ?
            ');
    
            $stmt->execute([$id]);
    
            return ($stmt->rowCount() > 0);
        } catch (\PDOException $e) {
            throw new \Exception(ExceptionPdo::translateError($e->getMessage()));
        } catch (\Exception $e) {
            throw new \Exception($e->getMessage());
        }
    }

    //USO INTERNO
    public static function update($id, $new_mac_address){
        try {
            $pdo = ConnectionMYSQL::getInstance();
    
            $stmt = $pdo->prepare('
                UPDATE tb_mac_address 
                SET mac_address = ?
                WHERE id = ?
            ');
    
            $stmt->execute([ $mac_address, $id]);
    
            return ($stmt->rowCount() > 0);
        } catch (\PDOException $e) {
            throw new \Exception(ExceptionPdo::translateError($e->getMessage()));
        } catch (\Exception $e) {
            throw new \Exception($e->getMessage());
        }
    }
    

}