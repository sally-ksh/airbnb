package team07.airbnb.entity;

import javax.persistence.Column;
import javax.persistence.Embedded;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import lombok.Getter;

@Entity
@Getter
public class Room {

    @Id @GeneratedValue
    @Column(name = "ROOM_ID")
    private Long id;
    //@Column(name = "HOST_ID")
    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "HOST_ID")
    private User host;
    private String roomName;
    @Embedded
    private Address address;
    private int price;
    private String description;
    private String composition;
    private int guestAmount;
    private int infantAmount;


}
