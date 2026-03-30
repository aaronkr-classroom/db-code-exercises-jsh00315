## 요구사항 작성 (동아리 관리)

1. 회원 가입 및 관리

- 사용자는 이름, 학번, 이메일, 연락처를 입력하여 회원으로 등록해야 한다.

- 시스템은 각 사용자에게 고유한 식별 번호를 자동으로 부여한다.

- 등록된 사용자는 자신의 연락처나 이메일 정보를 수정할 수 있어야 한다.

2. 동아리 개설 및 관리

- 운영진은 동아리 이름, 설립일 정보를 입력하여 새로운 동아리를 생성할 수 있다.

- 시스템은 각 동아리에 고유한 식별 번호를 자동으로 부여한다.

- 개설된 동아리는 동아리 이름을 수정하거나 설립일 정보를 관리할 수 있다.

3. 가입 신청 및 연결

- 사용자는 특정 동아리에 가입 신청을 할 수 있으며, 이때 동아리 내에서의 역할과 가입일 정보가 기록되어야 한다.

- 한 명의 사용자는 여러 개의 동아리에 중복으로 가입하여 활동할 수 있다.

- 하나의 동아리는 여러 명의 사용자를 회원으로 보유할 수 있다.

4. 역할 구분 및 운영

- 사용자는 가입 시 일반 회원, 운영진및 회장 등으로 역할이 구분된다.

- 멤버십 테이블을 통해 각 사용자가 동아리 내에서 어떤 권한을 가졌는지 관리한다.

- 운영진은 필요에 따라 회원의 역할 정보를 수정할 수 있다.

5. 데이터 유지 및 삭제

- 사용자가 탈퇴 및삭제가 될 경우, 해당 사용자의 모든 동아리 가입 내역은 즉시 삭제되어야 한다.

- 동아리가 폐쇄 및 삭제가 될 경우, 해당 동아리에 소속된 모든 멤버십 정보는 자동으로 삭제되어야 한다.

- 삭제 작업 시 참조 무결성을 유지하기 위해 ON DELETE CASCADE 제약을 적용한다.



## 데이터 설계(엔티티 정의)
   
- `User` (사용자): 시스템을 이용하는 개별 주체

    - `user_id` (PK): 고유 식별자 (Integer, Serial)

    - `student_no` (학번): 중복 불가 (Varchar)

    - `name` (이름): (Varchar)

    - `email` (이메일): (Varchar)

    - `phone` (연락처): (Varchar)

- `club` (동아리): 학교 내에 존재하는 동아리 단체

    - `club_id` (PK): 고유 식별자 (Integer, Serial)

    - `club_name` (동아리명): (Varchar)

    - `created_at` (설립일): (Date)
 
- `membership` (관계): 사용자와 동아리 간의 가입 연결 정보

   - `user_id` (FK): 사용자 식별자 (Integer)

   - `club_id` (FK): 동아리 식별자 (Integer, NOT NULL)

   - `role`: 동아리 내 역할 (Varchar)

   - `joined_date`: 동아리 가입일 (Date)


```postgresqlsql
-- 1. 사용자 테이블 생성
CREATE TABLE users (
                       user_id SERIAL PRIMARY KEY,
                       student_no VARCHAR(20) NOT NULL UNIQUE,
                       name VARCHAR(50) NOT NULL,
                       email VARCHAR(100),
                       phone VARCHAR(20)
);

-- 2. 동아리 테이블 생성
CREATE TABLE club (
                      club_id SERIAL PRIMARY KEY,
                      club_name VARCHAR(100) NOT NULL,
                      created_at DATE NOT NULL
);

-- 3. 사용자_동아리 관계 테이블 생성
CREATE TABLE membership (
                            user_id INTEGER NOT NULL,
                            club_id INTEGER NOT NULL,
                            role VARCHAR(20),
                            joined_date DATE DEFAULT CURRENT_DATE,

                            PRIMARY KEY (user_id, club_id),

                            CONSTRAINT fk_user FOREIGN KEY (user_id)
                                REFERENCES users(user_id) ON DELETE CASCADE,
                            CONSTRAINT fk_club FOREIGN KEY (club_id)
                                REFERENCES club(club_id) ON DELETE CASCADE
);


```
