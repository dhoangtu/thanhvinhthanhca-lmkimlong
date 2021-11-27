% Cài đặt chung\
\version "2.22.1"
\include "english.ly"

\header {
  title = "Phúc Thay Cho Người"
  composer = "Tv. 1"
  %arranger = "Lm. Kim Long"
  tagline = ##f
}

% Nhạc phiên khúc
nhacPhienKhucSop = \relative c'' {
  \partial 8 c8 |
  a g d4 |
  f8. f16 e8 f |
  a g4 a8 |
  b8. b16 g8 c |
  b16 (c) d4 d16 c |
  c8 e e, f |
  g4 r8 \bar "||"
  
  e16 e |
  f8 f d d |
  g4. g8 |
  g8. a16 f8 e |
  d4 r8 c |
  g'8. g16 e8 g |
  a4. b8 |
  g c b16 (c) e8 |
  d4 r8 d |
  b8 c16 c a8 a |
  g4. f8 |
  d8. d16 g8 g |
  c,2 ~ |
  c4 r8 \bar "|."
}

nhacPhienKhucAlto = \relative c' {
  \skip 8
  \repeat unfold 6 { \skip 2 }
  \skip 4.
  c16 c |
  d8 d c c |
  b4. b8 |
  c8. f16 d8 c |
  b4 r8 c |
  b8. b16 c8 e |
  f4. f8 |
  e a g16 (a) c8 |
  g4 r8 fs |
  g a16 g fs8 f! |
  e4. d8 |
  c8. c16 b8 b |
  c2 ~ |
  c4 r8
}

% Lời phiên khúc
loiPhienKhucSop = \lyrics {
  <<
    {
      \set stanza = "1."
      Phúc thay cho người
      không theo lời bọn ác nhân,
      không tiến bước cùng quân tội lỗi,
      không nhập bọn với phường kiêu căng.
    }
    \new Lyrics {
	    \set associatedVoice = "beSop"
	    \set stanza = "2."
	    Những quân tham tàn lao xao tựa vỏ trấu bay,
	    đâu đứng vững được khi xử án,
	    đâu hợp đoàn với người thiện tâm.
    }
    \new Lyrics {
	    \set associatedVoice = "beSop"
	    \set stanza = "3."
	    Chúa luôn thương tình trông coi
	    đường nẻo chính nhân,
	    khi những lối đường quân tội lỗi
	    luôn đẩy vào chốn bị diệt vong.
    }
  >>
  \set stanza = "ĐK:"
  Ai vui thú theo lề luật Chúa,
  suy đi gẫm lại đêm ngày,
  Họ như cây trồng bên suối,
  đúng mùa hoa quả trổ sinh,
  lá cành không khi nào tàn tạ,
  Họ làm gì cũng sẽ thành.
}

% Dàn trang
\paper {
  #(set-paper-size "a5")
  top-margin = 10\mm
  bottom-margin = 10\mm
  left-margin = 10\mm
  right-margin = 10\mm
  indent = #0
  #(define fonts
	 (make-pango-font-tree "Deja Vu Serif Condensed"
	 		       "Deja Vu Serif Condensed"
			       "Deja Vu Serif Condensed"
			       (/ 20 20)))
  print-page-number = ##f
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
    \override Lyrics.LyricSpace.minimum-distance = #1.5
    \override Score.BarNumber.break-visibility = ##(#f #f #f)
    \override Score.SpacingSpanner.uniform-stretching = ##t
  } 
}
