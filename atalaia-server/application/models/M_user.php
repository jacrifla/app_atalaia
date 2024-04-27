<?php
defined('BASEPATH') OR exit('No direct script access allowed');

class M_user extends CI_Model {
    
    public function createUser($name, $email, $phone, $password_hash) {
        $data = array(
            'name' => $name,
            'email' => $email,
            'phone' => $phone,
            'password_hash' => $password_hash
        );
        
        $this->db->insert('tb_user', $data);
        
        if ($this->db->affected_rows() > 0) {
            $response = array('code' => 1,
            'msg' => 'Usuário cadastrado corretamente');
        } else {
            $response = array('code' => 2,
            'msg' => 'Houve algum problema na inserção do usuário');
        }
        
        return $response;
    }
    
    public function checkUserExists($email, $phone) {
        $sql = "SELECT id "
        + "FROM tb_user"
        +"WHERE (email = "+$email+ "OR phone = "+$phone+")"
        +"AND deleted_at IS NULL";
        
        
        $query = $this->db->query($sql);

        if ($query->num_rows() > 0) {
            $response = array('code' => 1,
            'msg' => 'Usuário existente',
            'data' => $query->result());
        } else {
            $response = array('code' => 2,
            'msg' => 'Usuário não encontrado');
        }
        
        return $response;
    }
    
    public function getUserInfo($email,$phone,$password_hash){
        $sql = "SELECT *"
        + "FROM tb_user"
        +"WHERE (email = "+$email+ "OR phone = "+$phone+")"
        +"AND password_hash ="+ $password_hash
        +"AND deleted_at IS NULL";

        if((!empty($email) ||!empty($phone) )&& !empty($password_hash)){
            $query = $this->db->query($sql);

            if ($query->num_rows() > 0) {
                $response = array('code' => 1,
                'msg' => 'Sucesso',
                'data' => $query->result());
            } else {
                $response = array('code' => 2,
                'msg' => 'Erro ao consultar usuário');
            }
        }else{
            $response = array('code' => 2,
            'msg' => 'Erro ao consultar usuário');
        }
    }

    public function updateUser($id, $name, $email, $phone, $passwordHash) {
        // Lógica para atualizar os dados do usuário no banco de dados

        // Por exemplo, você pode usar a função update do Active Record do CodeIgniter
        $data = array(
            'name' => $name,
            'email' => $email,
            'phone' => $phone,
            'password_hash' => $passwordHash
        );

        $this->db->where('id', $id);
        $this->db->update('tb_user', $data);

        // Verifica se a atualização foi bem-sucedida
        if ($this->db->affected_rows() > 0) {
            $response = array('code' => 1, 'msg' => 'Usuário atualizado com sucesso');
        } else {
            $response = array('code' => 2, 'msg' => 'Falha ao atualizar o usuário');
        }

        return $response;
    }

    public function changePassword($id, $passwordHash) {
        // Lógica para alterar a senha do usuário no banco de dados

        // Por exemplo, você pode usar a função update do Active Record do CodeIgniter
        $data = array(
            'password_hash' => $passwordHash
        );

        $this->db->where('id', $id);
        $this->db->update('tb_user', $data);

        // Verifica se a atualização foi bem-sucedida
        if ($this->db->affected_rows() > 0) {
            $response = array('code' => 1, 'msg' => 'Senha do usuário alterada com sucesso');
        } else {
            $response = array('code' => 2, 'msg' => 'Falha ao alterar a senha do usuário');
        }

        return $response;
    }
    


    
}
