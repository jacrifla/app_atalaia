<?php

require_once 'Http.php';

// Http::get('/switch', 'SwitchController@getSwitches');
// Http::get('/switchgroup', 'GroupSwitchController@getGroups');
Http::post('/login', 'LoginController@login');
Http::post('/register', 'RegisterController@createUser');
// Http::put('/produto/edit', 'ProdutoController@edit');
// Http::delete('/produto/delete/{id}', 'ProdutoController@delete');
