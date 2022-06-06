package team07.airbnb.search;

import org.springframework.stereotype.Service;

import java.util.List;
import java.util.stream.Collectors;

import lombok.RequiredArgsConstructor;
import team07.airbnb.reservation.Period;

@RequiredArgsConstructor
@Service
public class SearchService {
	private final SearchRepository searchRepository;

	public SearchDto.RoomsResponse findRoomsOfRegion(SearchDto.LocationRequest request) {
		Period period = request.getPeriod();
		List<SearchRoomDto> searchRoomDtos = searchRepository.searchLocation(request.toSearchParam());
		return new SearchDto.RoomsResponse(
			searchRoomDtos.size(),
			toRoomCards(period, searchRoomDtos));
	}

	private List<SearchDto.RoomCard> toRoomCards(Period period, List<SearchRoomDto> searchRoomDtos) {
		return searchRoomDtos.stream()
			.map(searchRoom -> SearchDto.RoomCard.builder()
				.roomId(searchRoom.getRoomId())
				.roomName(searchRoom.getRoomName())
				.price(searchRoom.getPrice())
				.totalPrice(searchRoom.calculateTotalPrice(period))
				.isWished(searchRoom.isWished())
				.thumbnailImage(searchRoom.getThumbnailImage())
				.latitude(searchRoom.getLatitude())
				.longitude(searchRoom.getLongitude())
				.build())
			.collect(Collectors.toList());
	}
}
