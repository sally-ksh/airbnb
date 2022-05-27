package team07.airbnb.entity;

import javax.persistence.Embeddable;

@Embeddable
public class Address {

    private String province;
    private String city;
    private String gu;
    private String coordinate;

}
