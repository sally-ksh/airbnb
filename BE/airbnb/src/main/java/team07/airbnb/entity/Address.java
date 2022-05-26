package team07.airbnb.entity;

import javax.persistence.Embeddable;
import lombok.Getter;

@Embeddable
@Getter
public class Address {

    private String province;
    private String city;
    private String gu;
    private String coordinate;

}
