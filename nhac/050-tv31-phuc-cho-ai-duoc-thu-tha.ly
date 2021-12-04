% Cài đặt chung\
\version "2.22.1"
\include "english.ly"

\header {
  title = "Phúc Cho Ai Được Thứ Tha"
  composer = "Tv. 31"
  %arranger = "Lm. Kim Long"
  tagline = ##f
}

% Nhạc phiên khúc
nhacPhienKhucSop = \relative c'' {
  \partial 4 d8 a |
  a4. f8 |
  a g4 e8 |
  d4 r8 a |
  e' f4 d8 |
  g2 ~ |
  g4 d'8 a |
  a4. f8 |
  a g4 f8 |
  e4 r8 a, |
  e' f4 e8 |
  d2 ~ |
  d4 r8 \bar "||"
  
  d |
  d d bf (a) |
  d e g (f) |
  d4. d8 |
  g g4 f8 |
  e4 r8 f |
  e g4 bf8 |
  a2 ~ |
  a4 r8 a |
  d d bf (a) |
  g f f (g) |
  a4. a8 |
  f g4 f8 |
  e4 r8 a, |
  e' f4 e8 |
  d2 ~ |
  d4 \bar "|."
}

nhacPhienKhucAlto = \relative c' {
  
}

% Lời phiên khúc
loiPhienKhucSop = \lyrics {
  \set stanza = "ĐK:"
  Phúc cho ai được tha thứ lỗi lầm,
  được che lấp tội nhơ
  Phúc cho ai được Chúa không hỏi tội,
  lòng không vướng gian tà.
  <<
    {
      \set stanza = "1."
      Bao lâu con lặng câm không thú tội
      Toàn thân con rã rời,
      cả ngày kêu rống lên.
      Ngày đêm cánh tay Ngài đè nặng trĩu
      khiến hơi sức hao mòn tựa phơi giữa nắng hè.
    }
    \new Lyrics {
	    \set associatedVoice = "beSop"
	    \set stanza = "2."
	    Nên nay bao tội con xin thú nhận,
	    Chẳng giấu diếm chi Ngài,
	    để Ngài thương thứ tha,
	    Ngài khiến bốn bể nay cùng rộn rã,
	    cất cao khúc ca mừng vì con thoát nguy rồi.
    }
    \new Lyrics {
	    \set associatedVoice = "beSop"
	    \set stanza = "3."
	    Con nay xin tựa nương bên Chúa liên,
	    Ngài cứu thoát giữ gìn
	    xa vượt bao khó nguy.
	    Nguyện Chúa mãi răn dạy và chỉ lối,
	    mắt con ngước trông hoài lời chân lý của Ngài.
    }
    \new Lyrics {
	    \set associatedVoice = "beSop"
	    \set stanza = "4."
	    Bao đau thương dành cho quân ác thù,
	    Còn ai luôn tin cậy sẽ được luôn mến thương.
	    Người công minh sẽ reo hò nhảy múa,
	    cõi lòng ai ngay lành nào chung tiếng ca mừng.
    }
  >>
}

% Dàn trang
\paper {
  #(set-paper-size "a5")
  top-margin = 5\mm
  bottom-margin = 5\mm
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
