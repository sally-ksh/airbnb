package team07.airbnb.user;

import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Table;

import lombok.AllArgsConstructor;
import lombok.EqualsAndHashCode;
import lombok.NoArgsConstructor;
import lombok.ToString;

@ToString
@AllArgsConstructor
@NoArgsConstructor
@EqualsAndHashCode(of = "userId")
@Table(name = "airbnb_user")
@Entity
public class User {

    @Id @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long userId;
    private String email;
    private String nickName;
    private String phone;
    private String role;

    public User(String email, String nickName, String phone, String role) {
        this.email = email;
        this.nickName = nickName;
        this.phone = phone;
        this.role = role;
    }
}
