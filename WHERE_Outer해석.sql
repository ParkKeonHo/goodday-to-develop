-- 고객 테이블
CREATE TABLE customers (
    customer_id NUMBER PRIMARY KEY,
    name VARCHAR2(100),
    city VARCHAR2(50),
    created_at DATE DEFAULT SYSDATE
);

-- 주문 테이블
CREATE TABLE orders (
    order_id NUMBER PRIMARY KEY,
    customer_id NUMBER,
    amount NUMBER(10,2),
    order_date DATE,
    FOREIGN KEY (customer_id) REFERENCES customers(customer_id)
);

-- 데이터 입력
INSERT INTO customers VALUES (1, '김철수', '서울', TO_DATE('2024-01-10', 'YYYY-MM-DD'));
INSERT INTO customers VALUES (2, '이영희', '부산', TO_DATE('2024-02-15', 'YYYY-MM-DD'));
INSERT INTO customers VALUES (3, '박민수', '대구', TO_DATE('2024-03-05', 'YYYY-MM-DD'));
INSERT INTO customers VALUES (4, '박건호', '안양', TO_DATE('2024-04-05', 'YYYY-MM-DD'), 'N');

INSERT INTO orders VALUES (101, 1, 150000, TO_DATE('2024-03-10', 'YYYY-MM-DD'));
INSERT INTO orders VALUES (102, 1, 200000, TO_DATE('2024-03-15', 'YYYY-MM-DD'));
INSERT INTO orders VALUES (103, 2, 100000, TO_DATE('2024-03-20', 'YYYY-MM-DD'));
INSERT INTO orders VALUES (105, 3, 150000, TO_DATE('2024-04-01', 'YYYY-MM-DD')); -- 고객 정보 없는 주문

COMMIT;

SELECT a.CUSTOMER_ID,A.NAME, A.CITY, B.AMOUNT
FROM CUSTOMERS A, ORDERS B
WHERE A.CUSTOMER_ID = B.CUSTOMER_ID(+);

SELECT c.city, count(o.order_id) AS total_order, sum(o.amount) AS total_maount
FROM customers c, orders o
WHERE c.CUSTOMER_ID = o.CUSTOMER_ID
GROUP BY c.city;


ALTER TABLE customers ADD vip_yn CHAR(1) DEFAULT 'N' CHECK (vip_yn IN ('Y', 'N'));

SELECT a.customer_id, a.name, a.city, a.vip_yn, b.order_id, b.amount, b.order_date
FROM customers a, orders b
WHERE a.CUSTOMER_ID = b.CUSTOMER_ID(+)
AND b.amount(+) > 100000;
-- b가 없더라도 a는 보여줘 (+ 붙은 칼럼이 없더라도 상대 조인테이블의 내용은 )




