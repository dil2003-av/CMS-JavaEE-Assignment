package com.assignment.model;

import lombok.*;

@Getter
@Setter
@AllArgsConstructor
@NoArgsConstructor
@ToString

public class UserDTO {
    private int id;
    private String name;
    private String password;
    private String email;
    private String role;


}
