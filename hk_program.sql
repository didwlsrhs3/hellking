-- 1. 기존 hk_design_body_programs 테이블에 체인점 정보 추가
ALTER TABLE hk_design_body_programs ADD (
    chain_num NUMBER,
    program_room VARCHAR2(100), -- 프로그램실 이름
    operating_days VARCHAR2(50), -- 운영요일 (MON,TUE,WED,THU,FRI,SAT,SUN)
    operating_time VARCHAR2(100), -- 운영시간 (09:00-10:00)
    holiday_info VARCHAR2(200), -- 휴무일 정보
    max_capacity NUMBER DEFAULT 15, -- 최대 정원
    current_enrollment NUMBER DEFAULT 0, -- 현재 등록자수
    chain_price NUMBER, -- 체인점별 가격 (NULL이면 기본가격 사용)
    FOREIGN KEY (chain_num) REFERENCES hk_chains(chain_num)
);

-- 2. 기존 hk_design_body_enrollments 테이블에 체인점 정보 추가  
ALTER TABLE hk_design_body_enrollments ADD (
    chain_num NUMBER,
    FOREIGN KEY (chain_num) REFERENCES hk_chains(chain_num)
);

-- 3. 체인점별 프로그램 샘플 데이터

-- 바디 프로그램 데이터 삽입 (헬킹 체인점 형식)
INSERT INTO hk_design_body_programs (program_name, program_type, difficulty, duration, description, instructor, price, target_audience, equipment, schedule, chain_num, program_room, operating_days, operating_time, holiday_info, max_capacity, chain_price)
VALUES ('강남점 30일 집중 다이어트', 'DIET', 'BEGINNER', 30, '강남점에서 진행되는 집중 다이어트 프로그램입니다. 개인 맞춤형 식단과 운동을 병행합니다.', '김다이어트', 49000, '다이어트 초보자, 강남 지역 거주자', '운동매트, 아령, 밴드', '주 5회, 1회 50분 (오전반/오후반/저녁반)', 1, '스튜디오A', 'MON,TUE,WED,THU,FRI', '오전반: 09:00-09:50, 오후반: 14:00-14:50, 저녁반: 19:00-19:50', '일요일, 공휴일 휴무', 12, 55000);

INSERT INTO hk_design_body_programs (program_name, program_type, difficulty, duration, description, instructor, price, target_audience, equipment, schedule, chain_num, program_room, operating_days, operating_time, holiday_info, max_capacity, chain_price)
VALUES ('홍대점 근력강화 12주 완성', 'MUSCLE', 'INTERMEDIATE', 84, '홍대점 전용 근력강화 프로그램. 젊은 트레이너와 함께하는 재밌는 수업입니다.', '박홍대머슬', 89000, '20-30대, 근력 향상 목표', '바벨, 덤벨, 케틀벨, 스미스머신', '주 4회, 1회 60분', 2, '웨이트룸', 'MON,TUE,THU,FRI', '오전반: 10:00-11:00, 저녁반: 20:00-21:00', '수요일, 일요일 휴무', 8, 95000);

INSERT INTO hk_design_body_programs (program_name, program_type, difficulty, duration, description, instructor, price, target_audience, equipment, schedule, chain_num, program_room, operating_days, operating_time, holiday_info, max_capacity, chain_price)
VALUES ('잠실점 수영장 아쿠아로빅', 'CARDIO', 'BEGINNER', 42, '잠실점 수영장에서 진행되는 물속 유산소 운동입니다.', '이수영코치', 65000, '관절이 약한 분, 임산부, 중장년층', '수영복, 아쿠아슈즈', '주 3회, 1회 45분', 3, '수영장', 'MON,WED,FRI', '오전반: 11:00-11:45, 오후반: 15:00-15:45', '겨울철 수영장 정기점검일 휴무', 15, 70000);

INSERT INTO hk_design_body_programs (program_name, program_type, difficulty, duration, description, instructor, price, target_audience, equipment, schedule, chain_num, program_room, operating_days, operating_time, holiday_info, max_capacity, chain_price)
VALUES ('부산점 척추 재활 프로그램', 'REHAB', 'BEGINNER', 60, '부산점 물리치료사와 함께하는 척추 재활 운동입니다.', '정재활선생', 120000, '척추 질환자, 거북목, 골반 틀어짐', '폼롤러, 밸런스볼, 재활용 밴드', '주 2회, 1회 90분 (소수정예)', 4, '재활치료실', 'TUE,THU', '오전반: 10:00-11:30, 오후반: 14:00-15:30', '일요일, 공휴일 휴무', 6, 130000);

INSERT INTO hk_design_body_programs (program_name, program_type, difficulty, duration, description, instructor, price, target_audience, equipment, schedule, chain_num, program_room, operating_days, operating_time, holiday_info, max_capacity, chain_price)
VALUES ('대구점 토탈 바디 케어', 'MUSCLE', 'INTERMEDIATE', 90, '대구점 특별 프로그램. 근력+유산소+스트레칭 복합 운동입니다.', '최대구트레이너', 150000, '운동 경험자, 종합적인 체력 향상 목표', '종합 피트니스 장비', '주 3회, 1회 80분', 5, '종합운동실', 'MON,WED,FRI', '오전반: 09:00-10:20, 저녁반: 19:30-20:50', '일요일 휴무, 매월 마지막 토요일 휴무', 10, 160000);

COMMIT WORK;

-- 체인점별 프로그램 조회 뷰
CREATE OR REPLACE VIEW v_chain_programs AS
SELECT 
    p.program_num,
    p.program_name,
    p.program_type,
    p.difficulty,
    p.duration,
    p.description,
    p.instructor,
    NVL(p.chain_price, p.price) as final_price, -- 체인점 가격이 있으면 사용, 없으면 기본가격
    p.target_audience,
    p.equipment,
    p.schedule,
    p.chain_num,
    c.chain_name,
    c.address as chain_address,
    c.phone as chain_phone,
    p.program_room,
    p.operating_days,
    p.operating_time,
    p.holiday_info,
    p.max_capacity,
    p.current_enrollment,
    (p.max_capacity - p.current_enrollment) as available_spots,
    CASE 
        WHEN p.current_enrollment >= p.max_capacity THEN 'FULL'
        WHEN p.current_enrollment >= p.max_capacity * 0.8 THEN 'ALMOST_FULL'
        ELSE 'AVAILABLE'
    END as enrollment_status,
    p.is_active,
    p.created_at
FROM hk_design_body_programs p
JOIN hk_chains c ON p.chain_num = c.chain_num
WHERE p.is_active = 'Y';

-- 체인점별 프로그램 통계 뷰  
CREATE OR REPLACE VIEW v_chain_program_stats AS
SELECT 
    c.chain_num,
    c.chain_name,
    COUNT(p.program_num) as total_programs,
    COUNT(CASE WHEN p.program_type = 'DIET' THEN 1 END) as diet_programs,
    COUNT(CASE WHEN p.program_type = 'MUSCLE' THEN 1 END) as muscle_programs,
    COUNT(CASE WHEN p.program_type = 'CARDIO' THEN 1 END) as cardio_programs,
    COUNT(CASE WHEN p.program_type = 'REHAB' THEN 1 END) as rehab_programs,
    SUM(p.max_capacity) as total_capacity,
    SUM(p.current_enrollment) as total_enrollment,
    ROUND(AVG(NVL(p.chain_price, p.price)), 0) as avg_price
FROM hk_chains c
LEFT JOIN hk_design_body_programs p ON c.chain_num = p.chain_num AND p.is_active = 'Y'
GROUP BY c.chain_num, c.chain_name;

-- 테스트 쿼리들
SELECT * FROM v_chain_programs ORDER BY chain_name, program_type;
SELECT * FROM v_chain_program_stats;

-- 특정 체인점의 프로그램 조회
SELECT * FROM v_chain_programs WHERE chain_num = 1;

-- 특정 지역 근처 프로그램 조회 (예시)
SELECT * FROM v_chain_programs WHERE chain_address LIKE '%강남%';