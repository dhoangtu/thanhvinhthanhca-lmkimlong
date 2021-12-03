% Cài đặt chung\
\version "2.22.1"
\include "english.ly"

\header {
  title = "Con Tạ Ơn Chúa"
  composer = "Tv. 9A"
  %arranger = "Lm. Kim Long"
  tagline = ##f
}

% Nhạc phiên khúc
nhacPhienKhucSop = \relative c'' {
  g8 g a (g) |
  e2 |
  a4 b |
  c2 |
  c8 d e d16 (c) |
  a2 |
  a8 a c d16 (c) |
  g2 |
  g8. g16 g8 a16 (g) |
  e8 a r b16 (a) |
  g8 c4 d8 |
  e2 |
  c8. c16 d8 e |
  a,4 c8 a |
  g8. g16 d'8 d |
  \once \stemDown c2 \bar "||"
  
  c8 c e,4 |
  c8 c e d |
  f8. f16 d8 d |
  a'4 r8 g16 g |
  a8 c e e |
  d4. b16 (a) |
  g8. d16 g8 c |
  c2 \bar "|."
}

nhacPhienKhucAlto = \relative c'' {
  g8 g a (g) |
  e2 |
  d4 g |
  e2 |
  e8 g c [g] |
  f2 |
  f8 f a [f] |
  e2 |
  e8. e16 e8 [d] |
  c f r e |
  d e4 g8 |
  c2 |
  a8. a16 g8 g |
  f4 a8 f |
  e8. e16 f8 g |
  <e c>2
}

% Lời phiên khúc
loiPhienKhucSop = \lyrics {
  \set stanza = "ĐK:"
  Con xin hết lòng tạ ơn Chúa,
  Và con sẽ loan truyền mọi kỳ công của Ngài
  Con hân hoan nhảy mừng lên,
  nhảy mừng lên trong Chúa
  Và đàn ca chúc tụng Thánh Danh Ngài,
  lạy Đấng Tối Cao.
  <<
    {
      \set stanza = "1."
      Chúa xuất hiện địch thù con chạy trốn,
      té nhào mà chết.
      Ngài là vị thẩm phán chí công
      bênh vực quyền lợi cho con.
    }
    \new Lyrics {
	    \set associatedVoice = "beSop"
	    \set stanza = "2."
	    Chúa quát nạt diệt trừ quân tàn ác,
	    xóa sạch vạn kiếp,
	    Triệt bình địa thành quách chúng luôn,
	    muôn đời kẻ thù điêu linh
    }
    \new Lyrics {
	    \set associatedVoice = "beSop"
	    \set stanza = "3."
	    Chúa thống trị, Ngài lập ngai tòa xét đoán cả trần thế,
	    Và thưởng phạt theo lẽ chính trung
	    cai trị hợp đường công minh.
    }
    \new Lyrics {
	    \set associatedVoice = "beSop"
	    \set stanza = "4."
	    Với những người từng nhận biết Thánh Danh sẽ trọn tình mến,
	    Vì thực Ngài chẳng có lãng quên
	    những kẻ tìm Ngài trung kiên
    }
    \new Lyrics {
	    \set associatedVoice = "beSop"
	    \set stanza = "5."
	    Hãy tấu nhạc và hòa ca mừng Chúa giữa lòng đền thánh,
	    Hãy tường thuật cho các quốc gia
	    công việc Ngài thật uy linh
    }
  >>
}

% Dàn trang
\paper {
  #(set-paper-size "a5")
  top-margin = 3\mm
  bottom-margin = 3\mm
  left-margin = 10\mm
  right-margin = 10\mm
  indent = #0
  #(define fonts
	 (make-pango-font-tree "Deja Vu Serif Condensed"
	 		       "Deja Vu Serif Condensed"
			       "Deja Vu Serif Condensed"
			       (/ 20 20)))
  print-page-number = ##f
  page-count = #1
}

TongNhip = {
  \key c \major \time 2/4
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
        \notBePhu -3 { \nhacPhienKhucAlto }
      \new NullVoice = beSop \nhacPhienKhucSop
      \new Lyrics \lyricsto beSop \loiPhienKhucSop
      >>
  >>
  \layout {
    %\override Staff.TimeSignature.transparent = ##t
    \override Lyrics.LyricSpace.minimum-distance = #0.6
    \override Score.BarNumber.break-visibility = ##(#f #f #f)
    \override Score.SpacingSpanner.uniform-stretching = ##t
  } 
}
