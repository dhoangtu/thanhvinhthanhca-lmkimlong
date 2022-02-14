% Cài đặt chung\
\version "2.22.1"
\include "english.ly"

\header {
  title = \markup { \fontsize #1 "Đặt Niềm Tin Vào Chúa" }
  composer = "Tv. 77"
  tagline = ##f
}

% Nhạc phiên khúc
nhacPhienKhucSop = \relative c'' {
  \partial 4. b8 g g |
  a e4 fs8 |
  g4 r8 d |
  b'4 c8 a ~ |
  a fs g a |
  d,2 ~ |
  d8 b' g g |
  c b4 c8 |
  d4 r8 b |
  e4 c8 a ~ |
  a a d d |
  g,2 ~ |
  g4 r8 \bar "|." \break
  
  d |
  g4. g16 g |
  g4 \tuplet 3/2 { a8 b g } |
  e4 r8 e |
  c4. \slashedGrace { e16 ( } g8) |
  d4 \tuplet 3/2 { d8 g b } |
  a4 r8 b16 b |
  c8 a d d |
  fs,4. e16 g |
  d8 b d a' |
  g2 ~ |
  g8 \bar "||"
}

nhacPhienKhucAlto = \relative c'' {
  g8 e e |
  d c4 d8 |
  b4 r8 d |
  g4 e8 c ~ |
  c d e cs |
  d2 ~ |
  d8 g e e |
  a g4 a8 |
  b4 r8 g |
  c4 a8 fs ~ |
  fs d fs fs |
  g2 ~ |
  g4 r8
}

% Lời phiên khúc
loiPhienKhucSop = \lyrics {
  \set stanza = "ĐK:"
  Hãy đặt niềm tin vào Thiên Chúa,
  và chớ lãng quên kỳ công của Ngài
  Hãy đặt niềm tin vào Thiên Chúa,
  và nhớ tuân hành điều Ngài phán truyền.
  <<
    {
      \set stanza = "1."
      Đừng như cha ông xưa ngoan cố phản loạn,
      tâm địa thất thường, lòng dạ bất trung,
      không tuân giữ giao ước Chúa lập,
      không sống trọn lề luật Chúa ban.
    }
    \new Lyrics {
	    \set associatedVoice = "beSop"
	    \set stanza = "2."
      \override Lyrics.LyricText.font-shape = #'italic
	    Họ quên bao uy công tay Chúa thể hiện,
	    bao việc vĩ đại họ từng ngắm trông,
	    khi khai lối ngay giữa biển Hồng,
	    đưa dẫn họ lần lượt tiến quan.
    }
    \new Lyrics {
	    \set associatedVoice = "beSop"
	    \set stanza = "3."
	    Cột mây hơi hoang vu đưa dẫn ban ngày,
	    với cột lửa hồng rạng soi bóng đêm,
	    nơi khe đá khơi suối nước trào
	    cho đã thèm cửa họng khát khô.
    }
    \new Lyrics {
	    \set associatedVoice = "beSop"
	    \set stanza = "4."
      \override Lyrics.LyricText.font-shape = #'italic
	    Ngài cho mưa man -- na nuôi sống mỗi ngày,
	    bánh thật bởi trời tặng cho thế nhân,
	    xô chim cút sa xuống khắp trại,
	    dân chúng được từng hồi thỏa thuê.
    }
    \new Lyrics {
	    \set associatedVoice = "beSop"
	    \set stanza = "5."
	    Mà dân luôn vô tâm can mắc thêm tội,
	    các việc Chúa làm họ không muốn tin,
	    nên tay Chúa gom kiếp sống họ,
	    cho tuổi đời thình lình đứt ngang.
    }
    \new Lyrics {
	    \set associatedVoice = "beSop"
	    \set stanza = "6."
      \override Lyrics.LyricText.font-shape = #'italic
	    Ngài không ngơi yêu thương, không nỡ hủy diệt,
	    nén giận, chẳng đành bừng nộ khí lên,
	    Luôn luôn nhớ than chúng mỏng dòn,
	    như gió thoảng, ngày về thấy đâu.
    }
    \new Lyrics {
	    \set associatedVoice = "beSop"
	    \set stanza = "7."
	    Ngài đem Is -- ra -- el lên thánh điện Ngài,
	    tới vùng núi đồi Ngài đã chiếm cho,
	    Đo chia đất đâu đấy có phần,
	    cho mỗi tộc dựng lều trú cư.
    }
  >>
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
  system-system-spacing = #'((basic-distance . 0.1) (padding . 3))
  ragged-bottom = ##t
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
    \override Lyrics.LyricSpace.minimum-distance = #1.5
    \override Score.BarNumber.break-visibility = ##(#f #f #f)
    \override Score.SpacingSpanner.uniform-stretching = ##t
  } 
}
