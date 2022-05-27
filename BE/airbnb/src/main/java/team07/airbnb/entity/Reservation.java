package team07.airbnb.entity;

import java.time.LocalDate;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import lombok.EqualsAndHashCode;
import lombok.NoArgsConstructor;

@Entity
@NoArgsConstructor
@EqualsAndHashCode(of = "RESERVATION_ID")
public class Reservation {

    @Id @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "reservation_no")
    private Long reservationId;
    @ManyToOne
    @JoinColumn(name = "accomodation_id")
    private Room room;
    @ManyToOne
    @JoinColumn(name = "USER_ID")
    private User user;
    @Column(name = "start_at")
    private LocalDate checkinDate;
    @Column(name = "end_at")
    private LocalDate checkoutDate;
    @Column(name = "number_of_guest")
    private int guestAmount;
    @Column(name = "number_of_infant")
    private int infantAmount;
    private int price;

}
