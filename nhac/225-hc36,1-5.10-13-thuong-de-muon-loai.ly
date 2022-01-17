% Cài đặt chung\
\version "2.22.1"
\include "english.ly"

\header {
  title = "Thượng Đế Muôn Loài"
  composer = "Hc. 36,1-5.10-13"
  %arranger = "Lm. Kim Long"
  tagline = ##f
}

% Nhạc phiên khúc
nhacPhienKhucSop = \relative c' {
  f4. g8 |
  a4 \tuplet 3/2 { g8 bf a } |
  d,2 |
  d4. e16 c |
  f8 e a16 (bf) a8 |
  g4 r8 g16 f |
  bf8 bf bf bf16 a |
  c4. c16 d |
  bf8 g bf a |
  d,4. d16 e |
  <<
    {
      \voiceOne
      e8
    }
    \new Voice = "beSop" {
      \voiceTwo
      \once \override NoteColumn.force-hshift = #1.2
      \parenthesize
      c
    }
  >>
  \oneVoice
  c d
  <<
    {
      \voiceOne
      e
    }
    \new Voice = "beSop" {
      \voiceTwo
      \once \override NoteColumn.force-hshift = #-1
      \parenthesize
      g
    }
  >>
  \oneVoice
  f4 r8 \bar "||"
  
  c'8 |
  c4 \tuplet 3/2 { d8 c bf } |
  c8. a16 \tuplet 3/2 { f8 f f } |
  g4 \tuplet 3/2 { e8 f g } |
  a4 r8 f |
  g4. a8 |
  d,8. c16 \tuplet 3/2 { a'8 bf a } |
  g4. g16 (a) |
  f2 \bar "|."
}

nhacPhienKhucAlto = \relative c'' {
  R2*11
  r4.
  a8 |
  a4 \tuplet 3/2 { bf8 f g } |
  a8. f16 \tuplet 3/2 { d8 d d } |
  e4 \tuplet 3/2 { c8 d e } |
  f4 r8 d |
  c4. c8 |
  bf8. a16 \tuplet 3/2 { f'8 g f } |
  e4. e8 |
  f2
}

% Lời phiên khúc
loiPhienKhucSop = \lyrics {
  <<
    {
      \set stanza = "1."
      Lạy Thiên Chúa, Thượng Đế muôn loài,
      Xin dủ tình thương nhìn đến chúng con,
      Xin làm cho chư dân tôn sợ Chúa,
      Giơ cánh tay đè xuống dân ngoại
      cho chúng biết Ngài thực quyền uy.
    }
    \new Lyrics {
	    \set associatedVoice = "beSop"
	    \set stanza = "2."
	    Họ xem thấy Ngàu rất thánh thiện
	    trong cách Ngài cư xử với chúng con,
	    Thì nay cho con dân đây được thấy
	    Thiên Chúa cao cả đến muôn trùng
	    trong cách \markup { \italic \underline "Ngài" }
	    xử trị chư dân.
    }
    \new Lyrics {
	    \set associatedVoice = "beSop"
	    \set stanza = "3."
	    Nguyện cho chúng rầy cũng am tường
	    như chính đoàn con từng biết xưa nay,
	    Không thần minh đâu cao quang ngoài Chúa,
	    Xin cánh tay hiển hách uy hùng
	    cho tái diễn điềm lạ
	    \markup { \italic \underline "dấu" } thiêng.
    }
    \new Lyrics {
	    \set associatedVoice = "beSop"
	    \set stanza = "4."
	    Nhà Gia -- cóp, nguyện Chúa quy tụ
	    cho chiếm lại gia nghiệp thuở ban sơ,
	    Xin dủ thương dân riêng Ít -- ra -- en,
	    Xưa Chúa nhận làm trưởng nam Ngài,
	    thương đoái tới Giê -- ru -- sa -- lem.
    }
  >>
  \set stanza = "ĐK:"
  Xin cho khắp cả Si -- on vang dội
  lời truyền rao kỳ công của Chúa,
  Và cho thánh điện rực rỡ ánh vinh quang của Ngài.
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
        \notBePhu -3 { \nhacPhienKhucAlto }
      \new NullVoice = beSop \nhacPhienKhucSop
      \new Lyrics \lyricsto beSop \loiPhienKhucSop
      >>
  >>
  \layout {
    %\override Staff.TimeSignature.transparent = ##t
    \override Lyrics.LyricSpace.minimum-distance = #0.5
    \override Score.BarNumber.break-visibility = ##(#f #f #f)
    \override Score.SpacingSpanner.uniform-stretching = ##t
  } 
}
