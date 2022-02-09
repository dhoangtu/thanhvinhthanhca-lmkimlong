% Cài đặt chung\
\version "2.22.1"
\include "english.ly"

\header {
  title = \markup { \fontsize #1 "Xin Chúa Lắng Tai Nghe" }
  composer = "Tv. 139"
  %arranger = "Lm. Kim Long"
  tagline = ##f
}

% Nhạc phiên khúc
nhacPhienKhucSop = \relative c'' {
  \partial 8 a16 bf |
  a8 f d a' |
  g4. g16 a |
  g8 f g e |
  d4 r8 c16 c |
  c8 f d f |
  g4. g16 g |
  bf8 c e, g |
  f2 \bar "||"
  
  f8. f16 f8 e |
  a4. f8 |
  f a bf16 (a) f8 |
  g2 |
  bf8. g16 bf8 d |
  c4. c8 |
  a a bf g |
  f4 r8 \bar "|."
}

nhacPhienKhucAlto = \relative c' {
  r8 |
  R2*8
  f8. f16 f8 e |
  a4. d,8 |
  d f g16 (f) d8 |
  c2 |
  g'8. d16 g8 bf |
  a4. a8 |
  f f d e |
  f4 r8
}

% Lời phiên khúc
loiPhienKhucSop = \lyrics {
  <<
    {
      \set stanza = "1."
      Xin cứu con khỏi phường ác tâm,
      xin giữ con khỏi lũ tham tàn,
      lòng họ đầy chước độc mưu thâm,
      Ngày ngày luôn tính chuyện đấu tranh.
    }
    \new Lyrics {
	    \set associatedVoice = "beSop"
	    \set stanza = "2."
	    Xin Chúa thương bảo vệ giúp con
	    xa thoát quân tội lỗi trên đời,
	    họ từng mài lưỡi tựa hổ mang,
	    Ngậm nọc như rắn độc phun người.
    }
    \new Lyrics {
	    \set associatedVoice = "beSop"
	    \set stanza = "3."
	    Quân dã man luôn rình tiến công,
	    xin Chúa thương giải thoát con cùng,
	    họ ngầm đặt bẫy dò hại con
	    Và bủa giăng lưới đầy trên đường.
    }
    \new Lyrics {
	    \set associatedVoice = "beSop"
	    \set stanza = "4."
	    Xin Chúa thương trở thành sức thiêng,
	    nên mũ con đội lúc lâm trận,
	    đừng để bọn hung đồ hỉ hoan,
	    Đừng để mưu ác họ viên thành.
    }
    \new Lyrics {
	    \set associatedVoice = "beSop"
	    \set stanza = "5."
	    Bao tiếng nham hiểm họ thốt ra
	    nay Chúa cho lại trút lên họ,
	    đổ lửa hồng trên họ như mưa,
	    Ngụp vực sâu hết đường ngóc lên.
    }
    \new Lyrics {
	    \set associatedVoice = "beSop"
	    \set stanza = "6."
	    Thiên Chúa bang trợ người khốn nguye,
	    bênh đỡ ai nghèo khó cơ cùng,
	    người lành được ở gần Thiên Nhan,
	    Người thẳng ngay tán tụng Thánh Danh.
    }
  >>
  \set stanza = "ĐK:"
  Con thân thư cùng Chúa:
  Ngài là Thiên Chúa của con,
  Xin dủ thương lắng tai,
  lắng tai nghe tiếng con cầu.
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
  page-count = 1
}

TongNhip = {
  \key f \major \time 2/4
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
    \override Lyrics.LyricSpace.minimum-distance = #1.2
    \override Score.BarNumber.break-visibility = ##(#f #f #f)
    \override Score.SpacingSpanner.uniform-stretching = ##t
  } 
}
