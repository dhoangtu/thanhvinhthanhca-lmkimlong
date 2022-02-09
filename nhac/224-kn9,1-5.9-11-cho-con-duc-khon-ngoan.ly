% Cài đặt chung\
\version "2.22.1"
\include "english.ly"

\header {
  title = \markup { \fontsize #1 "Cho Con Đức Khôn Ngoan" }
  composer = "Kn. 9,1-5,9-11"
  %arranger = "Lm. Kim Long"
  tagline = ##f
}

% Nhạc phiên khúc
nhacPhienKhucSop = \relative c'' {
  \partial 8 g16 fs |
  b8. e,16 \tuplet 3/2 { g8 g a } |
  d,4. d8 |
  d fs4 g8 |
  \slashedGrace { a16 (b } a4) \tuplet 3/2 { c8 c a } |
  a8. a16 \tuplet 3/2 { e'8 d d } |
  b4 \tuplet 3/2 { g8 c b } |
  a8. fs16 \tuplet 3/2 { a8 g e } |
  d4 r8 \bar "||" \break
  
  b'16 b |
  b4. c16 b |
  a8. g16 \tuplet 3/2 { g8 a b } |
  d,4 \tuplet 3/2 { d8 fs g } |
  a8. a16 \tuplet 3/2 { e'8 cs cs } |
  d4 r8 b16 b |
  b4. c16 (b) |
  a8. g16 \tuplet 3/2 { g8 a b } |
  \slashedGrace { d,16 (e } d4) \tuplet 3/2 { d8 fs g } |
  a8. e16 \tuplet 3/2 { a8 b g } |
  g2 ~ |
  g4 r8 \bar "|."
}

nhacPhienKhucAlto = \relative c' {
  
}

% Lời phiên khúc
loiPhienKhucSop = \lyrics {
  <<
    {
      \set stanza = "1."
      Muôn lạy Chúa tổ tiên con kính thờ,
      Ngài từ bi lân tuất,
      Chúa phán một lời là tác sinh muôn loài,
      Dùng Đức Khôn Ngoan mà nắn nên con người.
    }
    \new Lyrics {
	    \set associatedVoice = "beSop"
	    \set stanza = "2."
	    Con người đó Ngài trao cho
	    lãnh đạo mọi vật Ngài tạo tác
	    Hãy sống thiện toàn và đoán phân công bình,
	    Lòng trí đơn ngay, phải trái luôn minh bạch.
    }
    \new Lyrics {
	    \set associatedVoice = "beSop"
	    \set stanza = "3."
	    Cho dù có một ai nơi thế trần,
	    dù thập toàn đi nữa,
	    Nếu đã chẳng nhận được đức khôn ngoan Ngài,
	    Thì có ra chi, kể cũng như không vậy.
    }
    \new Lyrics {
	    \set associatedVoice = "beSop"
	    \set stanza = "4."
	    Công việc Chúa Sự Khôn Ngoan thấu tường,
	    vì ở gần bên Chúa,
	    vẫn đã hiện diện hồi tác sinh muôn loài,
	    Hiểu biết những chi hợp với huấn lệnh Ngài.
    }
    \new Lyrics {
	    \set associatedVoice = "beSop"
	    \set stanza = "5."
	    Xin gửi tới Sự Khôn Ngoan của Ngài
	    từ trời cao tôn thánh,
	    phái đến từ tòa rực ánh vinh quang Ngài,
	    Cộng tác với con làm Chúa luôn vui lòng.
    }
    \new Lyrics {
	    \set associatedVoice = "beSop"
	    \set stanza = "6."
	    Ôi lạy Chúa, Sự Khôn Ngoan của Ngài,
	    mọi việc đều thông suốt,
	    khéo léo thận trọng chỉ dẫn con thi hành,
	    Và lấy uy linh gìn giữ con khôn rời.
    }
  >>
  \set stanza = "ĐK:"
  Xin cho con Đức Khôn Ngoan hằng ngự bên hữu Ngài,
  Đừng đuổi con đi mà chẳng nhận làm con.
  Thân con đây, Chúa ơi, đời mòng manh vắn vỏi,
  là phận tôi tớ, là con nữ tỳ Ngài.
}

% Dàn trang
\paper {
  #(set-paper-size "a5")
  top-margin = 3\mm
  bottom-margin = 3\mm
  left-margin = 3\mm
  right-margin = 3\mm
  indent = #0
  #(define fonts
	 (make-pango-font-tree "Deja Vu Serif Condensed"
	 		       "Deja Vu Serif Condensed"
			       "Deja Vu Serif Condensed"
			       (/ 20 20)))
  print-page-number = ##f
  system-system-spacing = #'((basic-distance . 0.1) (padding . 2))
}

TongNhip = {
  \key g \major \time 2/4
  \set Timing.beamExceptions = #'()
  \set Timing.baseMoment = #(ly:make-moment 1/4)
}

% Đổi kích thước nốt cho bè phụ
notBePhu =
#(define-music-function (font-size music) (number? ly:music?)
   (for-some-music
     (lambda (m)
       (if (music-is-of-type? m 'rhythmic-event)
           (begin
             (set! (ly:music-property m 'tweaks)
                   (cons `(font-size . ,font-size)
                         (ly:music-property m 'tweaks)))
             #t)
           #f))
     music)
   music)

\score {
  \new ChoirStaff <<
    \new Staff \with {
        \consists "Merge_rests_engraver"
        printPartCombineTexts = ##f
      }
      <<
      \new Voice \TongNhip \partCombine 
        \nhacPhienKhucSop
        \notBePhu -1 { \nhacPhienKhucAlto }
      \new NullVoice = beSop \nhacPhienKhucSop
      \new Lyrics \lyricsto beSop \loiPhienKhucSop
      >>
  >>
  \layout {
    %\override Staff.TimeSignature.transparent = ##t
    \override Lyrics.LyricSpace.minimum-distance = #0.8
    \override Score.BarNumber.break-visibility = ##(#f #f #f)
    \override Score.SpacingSpanner.uniform-stretching = ##t
  } 
}
