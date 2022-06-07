package team07.airbnb.search;

import java.util.List;

public interface SearchRepository {
	List<SearchRoomDto> searchLocation(SearchParam searchParam);
}
