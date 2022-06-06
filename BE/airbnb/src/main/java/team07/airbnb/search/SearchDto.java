package team07.airbnb.search;

import java.math.BigDecimal;
import java.time.LocalDate;
import java.util.List;

import javax.validation.constraints.NotNull;
import javax.validation.constraints.Size;

import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;
import team07.airbnb.reservation.Period;
import team07.airbnb.reservation.calculation.WeeklyDiscountPolicy;

public class SearchDto {
	@Data
	@NoArgsConstructor
	public static class LocationRequest {
		@NotNull
		@Size(min = 2)
		private String location;
		private LocalDate checkinDate;
		private LocalDate checkoutDate;
		private int minPrice;
		private int maxPrice;
		private int guestAmount;

		public SearchParam toSearchParam() {
			return new SearchParam(
				location.trim(),
				checkinDate,
				checkoutDate,
				getSearchPrice(getPeriod()),
				guestAmount
			);
		}

		public Period getPeriod() {
			return Period.of(checkinDate, checkoutDate);
		}

		private SearchPrice getSearchPrice(Period period) {
			return SearchPrice.builder()
				.weeklyDiscountPolicy(new WeeklyDiscountPolicy())
				.period(period)
				.minPrice(minPrice)
				.maxPrice(maxPrice)
				.build();
		}
	}

	public static class RoomsResponse {
		private final int numberOfRooms;
		private final List<RoomCard> rooms;

		public RoomsResponse(int numberOfRooms, List<RoomCard> rooms) {
			this.numberOfRooms = numberOfRooms;
			this.rooms = rooms;
		}
	}

	@Data
	public static class RoomCard {
		private Long roomId;
		private String roomName;
		private int price;
		private int totalPrice;
		private String thumbnailImage;
		private boolean isWished;
		private BigDecimal latitude;
		private BigDecimal longitude;

		@Builder
		public RoomCard(Long roomId, String roomName, int price, int totalPrice, String thumbnailImage,
			boolean isWished,
			BigDecimal latitude, BigDecimal longitude) {
			this.roomId = roomId;
			this.roomName = roomName;
			this.price = price;
			this.totalPrice = totalPrice;
			this.thumbnailImage = thumbnailImage;
			this.isWished = isWished;
			this.latitude = latitude;
			this.longitude = longitude;
		}
	}
}
