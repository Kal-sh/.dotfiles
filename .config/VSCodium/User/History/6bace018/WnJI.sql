use hilcoe;

create table family (
    Fid int PRIMARY KEY IDENTITY,
    NAMES VARCHAR(20) not NULL,
    fam_ex int
)

CREATE TABLE exercise (
    Eid int PRIMARY key IDENTITY,
    ex_name VARCHAR(10) not NULL,
    duration int not null,
    ex_date DATE,
    ex_day VARCHAR(10)
)

CREATE TABLE sport (
    Sid int PRIMARY KEY IDENTITY,
    sp_name VARCHAR(10)
)

INSERT into
    family
VALUES ('father'),
    ('mother'),
    ('brother'),
    ('sister')

insert into
    exercise
VALUES (
        'jogging',
        '40',
        '10/11/2020',
        'Monday'
    ) (
        'plank',
        '30',
        '11/11/2020',
        'Tuesday'
    ) (
        'jumping rope',
        '40',
        '10/11/2020',
        'Monday'
    ) (
        'push up',
        '40',
        '10/11/2020',
        'Monday'
    ) (
        'push up',
        '40',
        '10/11/2020',
        'Monday'
    )

drop table family;

ALTER table family
add CONSTRAINT fam_fn FOREIGN KEY (fam_ex) REFERENCES exercise (Eid);

insert into family VALUES ('father', 2)

ALTER table family add fam_ex int

select * from family;

SELECT * FROM exercise;