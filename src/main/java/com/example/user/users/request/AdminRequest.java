package com.example.user.users.request;

public record AdminRequest (
        String id,
        String firstname,
        String lastname,
        String email,
        String phoneNumber,
        String password
){}
