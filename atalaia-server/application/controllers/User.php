<?php
defined('BASEPATH') OR exit('No direct script access allowed');

class User extends CI_Controller {
    
    private $json;
    private $result;
    
    private $id;
    private $name;
    private $email;
    private $phone;
    private $password_hash;
    private $created_at;
    private $updated_at;
    private $deleted_at;
    
    public function getId() {
        return $this->id;
    }
    
    public function getName() {
        return $this->name;
    }
    
    public function getEmail() {
        return $this->email;
    }
    
    public function getPhone() {
        return $this->phone;
    }
    
    public function getPasswordHash() {
        return $this->password_hash;
    }
    
    public function getCreatedAt() {
        return $this->created_at;
    }
    
    public function getUpdatedAt() {
        return $this->updated_at;
    }
    
    public function getDeletedAt() {
        return $this->deleted_at;
    }
    
    public function setId($id) {
        $this->id = $id;
    }
    
    public function setName($name) {
        $this->name = $name;
    }
    
    public function setEmail($email) {
        $this->email = $email;
    }
    
    public function setPhone($phone) {
        $this->phone = $phone;
    }

    // public function setPassword($password) {
    //     $this->password = $password;
    // }
    
    public function setPasswordHash($password_hash) {
        $this->password_hash = $password_hash;
    }
    
    public function setCreatedAt($created_at) {
        $this->created_at = $created_at;
    }
    
    public function setUpdatedAt($updated_at) {
        $this->updated_at = $updated_at;
    }
    
    public function setDeletedAt($deleted_at) {
        $this->deleted_at = $deleted_at;
    }



    
    public function createUser() {
        $json = file_get_contents('php://input');
        $result = json_decode($json);
        
        $listParam = array("name" => '0',
        "email" => '0',
        "phone" => '0',
        "password_hash" => '0');
        
        if(checkParams($result, $listParam)== 1) {
            $this->setName($result->name);
            $this->setEmail($result->email);
            $this->setPhone($result->phone);
            $this->setPasswordHash(password_hash($result->password_hash, PASSWORD_BCRYPT));
            
            if(trim($this->getName()) == ""){
                $response = array('code' => 3,
            'msg' => 'Campo Nome deve ser preenchido.');
                
            }else if(trim($this->getEmail()) == ""){
                $response = array('code' => 4,
                'msg' => 'Campo E-mail deve ser preenchido.');
                
            }else if(trim($this->getPhone()) == ""){
                $response = array('code' => 5,
                'msg' => 'Campo Telefone deve ser preenchido.');
                
            }else if(trim($this->getPasswordHash()) == ""){
                $response = array('code' => 6,
                'msg' => 'Campo Senha deve ser preenchido.');
                
            }else{
                // Realizo a instância no MODEL
                $this->load->model('M_user');
                

                $response = $this->M_user->createUser(
                    $this->getName(),
                    $this->getEmail(),
                    $this->getPhone(),
                    $this->getPasswordHash()
                );
            }
            
            
            
        } else {
            $response = array('code' => 99,
            'msg' => 'Os campos vindos do FrontEnd não apresentam o método de inserção, verifique!');
        }
        echo json_encode($response);
    }
    
    public function checkUser() {
        $json = file_get_contents('php://input');
        $result = json_decode($json);
        
        $listParam = array("id" => '0',
        "name" => '0',
        "email" => '0',
        "phone" => '0',
        "created_at" => '0',
        "updated_at" => '0',
        "deleted_at" => '0');
        
        if(checkParams($result, $listParam)== 1) {
            $this->setId($result->id);
            $this->setName($result->name);
            $this->setEmail($result->email);
            $this->setPhone($result->phone);
            $this->setCreatedAt($result->created_at);
            $this->setUpdatedAt($result->updated_at);
            $this->setDeletedAt($result->deleted_at);
            
            // Realizo a instância no MODEL
            $this->load->model('M_user');
            
            $response = $this->M_user->checkUser(
                $this->getId(),
                $this->getName(),
                $this->getEmail(),
                $this->getPhone(),
                $this->getCreatedAt(),
                $this->getUpdatedAt(),
                $this->getDeletedAt()
            );
            
            echo json_encode($response);
        } else {
            $response = array('code' => 99,
            'msg' => 'Os campos vindos do FrontEnd não apresentam o método de consulta, verifique!');
            echo json_encode($response);
        }
    }
    
    public function updateUser(){

        $json = file_get_contents('php://input');
        $result = json_decode($json);
        
        $listParam = array(
        "id" =>'0',
        "name" => '0',
        "email" => '0',
        "phone" => '0',
        "password_hash" => '0');
        
        if(checkParams($result, $listParam)== 1) {
            $this->setId($result->id);
            $this->setName($result->name);
            $this->setEmail($result->email);
            $this->setPhone($result->phone);
            $this->setPasswordHash($result->password_hash);
            
            if(trim($this->getId()) == ""){
                $response = array('code' => 7,
            'msg' => 'Campo Id deve ser preenchido.');
                
            }else if(trim($this->getName()) == ""){
                $response = array('code' => 3,
            'msg' => 'Campo Nome deve ser preenchido.');
                
            }else if(trim($this->getEmail()) == ""){
                $response = array('code' => 4,
                'msg' => 'Campo E-mail deve ser preenchido.');
                
            }else if(trim($this->getPhone()) == ""){
                $response = array('code' => 5,
                'msg' => 'Campo Telefone deve ser preenchido.');
                
            }else if(trim($this->getPasswordHash()) == ""){
                $response = array('code' => 6,
                'msg' => 'Campo Senha deve ser preenchido.');
                
            }else{
                // Realizo a instância no MODEL
                $this->load->model('M_user');
                
                $response = $this->M_user->updateUser(
                    $this->getId(),
                    $this->getName(),
                    $this->getEmail(),
                    $this->getPhone(),
                    $this->getPasswordHash()
                );
            }
            
            
            
        } else {
            $response = array('code' => 99,
            'msg' => 'Os campos vindos do FrontEnd não apresentam o método de inserção, verifique!');
        }
        echo json_encode($response);

    }

    

    public function changePassword(){

        $json = file_get_contents('php://input');
        $result = json_decode($json);
        
        $listParam = array(
        "id" =>'0',
        "password_hash" => '0');
        
        if(checkParams($result, $listParam)== 1) {
            $this->setId($result->id);
            $this->setPasswordHash(password_hash($result->password_hash, PASSWORD_BCRYPT));
            if(trim($this->getId()) == ""){
                $response = array('code' => 7,
            'msg' => 'Campo Id deve ser preenchido.');
                
            }else if(trim($this->getPasswordHash()) == ""){
                $response = array('code' => 6,
                'msg' => 'Campo Senha deve ser preenchido.');
                
            }else{
                // Realizo a instância no MODEL
                $this->load->model('M_user');
                
                $response = $this->M_user->changePassword(
                    $this->getId(),
                    $this->getPasswordHash()
                );
            }
            
            
            
        } else {
            $response = array('code' => 99,
            'msg' => 'Os campos vindos do FrontEnd não apresentam o método de inserção, verifique!');
        }
        echo json_encode($response);

    }

    public function deleteUser(){

    }

    
    
    
}
