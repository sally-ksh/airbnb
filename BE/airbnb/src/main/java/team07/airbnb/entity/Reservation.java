package team07.airbnb.entity;

import java.util.Date;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import lombok.Getter;

@Entity
@Getter
public class Reservation {

    @Id @GeneratedValue
    @Column(name = "RESERVATION_ID")
    private Long id;
    @ManyToOne
    @JoinColumn(name = "ROOM_ID")
    private Room room;
    @ManyToOne
    @JoinColumn(name = "USER_ID")
    private User user;
    private Date checkinDate;
    private Date checkoutDate;
    private int guestAmount;
    private int infantAmount;
    private int totalPrice;

}
