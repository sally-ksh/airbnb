package team07.airbnb.search;

import static team07.airbnb.image.QImage.image;
import static team07.airbnb.reservation.QReservation.reservation;
import static team07.airbnb.room.QRoom.room;
import static team07.airbnb.wishlist.QWishlist.wishlist;

import com.querydsl.core.types.Predicate;
import com.querydsl.core.types.dsl.BooleanExpression;
import com.querydsl.jpa.impl.JPAQueryFactory;

import org.springframework.stereotype.Repository;
import org.springframework.util.StringUtils;

import java.time.LocalDate;
import java.util.List;
import java.util.Objects;

import javax.persistence.EntityManager;

@Repository
public class SearchRepositoryImpl implements SearchRepository{
	private final JPAQueryFactory queryFactory;

	public SearchRepositoryImpl(EntityManager entityManager) {
		this.queryFactory = new JPAQueryFactory(entityManager);
	}

	@Override
	public List<SearchRoomDto> searchLocation(SearchParam searchParam) {
		return queryFactory
			.select(new QSearchRoomDto(
				room.id.as("roomId"),
				room.roomName,
				room.roomPricePerDay.as("price"),
				image.imageLink.as("thumbnailImage"),
				wishlist.isNotNull().as("isWished"),
				room.address))
			.from(room)
			.innerJoin(image).on(room.id.eq(image.room.id))
			.leftJoin(wishlist).on(room.id.eq(wishlist.room.id))
			.where(
				locationEq(searchParam.getLocation()),
				dateGoe(searchParam.getStartAt()),
				dateLoe(searchParam.getEndAt()),
				priceGoe(searchParam.getMinPrice()),
				priceLoe(searchParam.getMaxPrice()),
				peoplesGoe(searchParam.getGuestAmount()),
				image.imageOrder.eq(1)
				)
			.fetch();


	}
	private BooleanExpression locationEq(String location) {
		return StringUtils.hasText(location) ?
			room.address.roomCity.contains(location)
			.or(room.address.roomState.contains(location))
			.or(room.address.roomCity.contains(location))
			: null;
	}

	private BooleanExpression dateGoe(LocalDate startAt) {
		return Objects.isNull(startAt) ? null : reservation.startAt.eq(startAt);
	}

	private BooleanExpression dateLoe(LocalDate endAt) {
		return Objects.isNull(endAt) ? null : reservation.endAt.eq(endAt);
	}

	private BooleanExpression priceGoe(int minPrice) {
		return minPrice > 0 ? room.roomPricePerDay.goe(minPrice) : null;
	}

	private BooleanExpression priceLoe(int maxPrice) {
		return maxPrice > 0 ? room.roomPricePerDay.goe(maxPrice) : null;
	}

	private Predicate peoplesGoe(int guestAmount) {
		return guestAmount > 0 ? room.maxNumberOfGuest.goe(guestAmount) : null;
	}
}
