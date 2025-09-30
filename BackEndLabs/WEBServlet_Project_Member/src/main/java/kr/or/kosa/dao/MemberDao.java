package kr.or.kosa.dao;

import kr.or.kosa.dto.MemberDTO;

public class MemberDao {
	  // 임시 사용자 데이터
    private MemberDTO[] users = { //db에서 select한 데이터로 친다 (db에 있다고 가정)
        new MemberDTO("admin", "1234", "관리자", "admin"),
        new MemberDTO("user", "1234", "일반사용자", "user")
    };

    public MemberDTO login(String id, String pw) {
        for (MemberDTO user : users) {
            if (user.getId().equals(id) && user.getPw().equals(pw)) {
                return user; // 로그인 성공 //페이지마다 권한 필요하니까 검증하고 dto에 던짐
            }
        }
        return null; // 로그인 실패
    }
}
