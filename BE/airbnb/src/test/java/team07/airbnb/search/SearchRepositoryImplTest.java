package team07.airbnb.search;

import static org.assertj.core.api.Assertions.assertThat;
import static org.junit.jupiter.api.Assertions.*;

import org.junit.jupiter.api.DisplayName;
import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.test.context.ActiveProfiles;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

@ActiveProfiles("dev")
@SpringBootTest
@Transactional
class SearchRepositoryImplTest {
	private final SearchRepositoryImpl searchRepository;

	public SearchRepositoryImplTest(@Autowired SearchRepositoryImpl searchRepository) {
		this.searchRepository = searchRepository;
	}

	@Test
	@DisplayName("최소 검색어 지역명 검색 요청에 대한 조회 결과를 확인한다.")
	void check_result_of_searching_by_location() {
		SearchParam searchParam = new SearchParam("강원", null,null, null, 0);
		List<SearchRoomDto> roomCards = searchRepository.searchLocation(searchParam);

		assertThat(roomCards).extracting("address.roomState").contains("강원도");
	}
}
