package team07.airbnb.entity;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;

@Entity
public class User {

    @Id @GeneratedValue
    @Column(name = "USER_ID")
    private Long id;
    private String userLoginId;
    private String userPassword;
    private String userName;
    private String userProfileImagePath;


}
