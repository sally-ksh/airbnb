package team07.airbnb.entity;

import java.util.Date;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;

@Entity
public class Review {

    @Id @GeneratedValue
    @Column(name = "REVIEW_ID")
    private Long id;
    @ManyToOne
    @JoinColumn(name = "ROOM_ID")
    private Room room;
    @ManyToOne
    @JoinColumn(name = "USER_ID")
    private User user;

    private int starRating;
    private String content;
    private Date writeDate;
}
