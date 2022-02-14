% Cài đặt chung\
\version "2.22.1"
\include "english.ly"

\header {
  title = \markup { \fontsize #1 "Từ Vực Thẳm" }
  composer = "Tv. 129"
  tagline = ##f
}

% Nhạc phiên khúc
nhacPhienKhucSop = \relative c' {
  \partial 4 a8 a |
  f'8. g16 g8 g 
  e4 g8 f16 (g) |
  a4 \tuplet 3/2 { d8 cs e } |
  d2 |
  c!?8. d16 c8 bf |
  a4. a,8 |
  e'4 \tuplet 3/2 { g8 a e } |
  \partial 4. d4 r8 \bar "||" \break
  
  \set Staff.explicitKeySignatureVisibility = #end-of-line-invisible
  \set Staff.printKeyCancellation = ##f
  \key d \major
  \partial 8 d8 |
  a'4. a16 a |
  g4. b8 |
  a4. a16 a |
  d8 d \slashedGrace { b16 ( } a8) fs |
  g2 |
  a4. e8 |
  g4 \tuplet 3/2 { fs8 g b } |
  a4 r8 fs16 g |
  fs8 e g a |
  d,2 \bar "|."
}

nhacPhienKhucAlto = \relative c' {
  r4 |
  R2*7
  r4.
  
  \key d \major
  d8 |
  fs4. fs16 fs |
  e4. g8 |
  fs4. fs16 fs |
  b8 g fs [d] |
  e2 |
  cs4. cs8 |
  e4 \tuplet 3/2 { d8 e g } |
  fs4 r8 d16 e |
  d8 d cs cs |
  d2
}

% Lời phiên khúc
loiPhienKhucSop = \lyrics {
  <<
    {
      \set stanza = "1."
      Từ vực thẳm con kêu lên Ngài,
      thân lạy Chúa xin Ngài lắng nghe.
      Xin ghé tai thẩm nhận lời con
      tha thiết khẩn cầu.
    }
    \new Lyrics {
	    \set associatedVoice = "beSop"
	    \set stanza = "2."
      \override Lyrics.LyricText.font-shape = #'italic
	    Lòng mòn mỏi con trông mong Ngài,
	    bao lời Chúa con hằng vững tin,
	    Như lính canh mong đợi bình đông,
	    con ngóng trông Ngài.
    }
    \new Lyrics {
	    \set associatedVoice = "beSop"
	    \set stanza = "3."
	    Vì Ngài vẫn khoan dung, nhân từ,
	    ơn giải thoát luôn rộng rãi ban,
	    Thương cứu Ít -- ra -- en vượt qua bao ách tội tình.
    }
  >>
  \set stanza = "ĐK:"
  Vì nếu Chúa chấp tội, Chúa ơi,
  thì nào ai vững đứng được chăng?
  Nhưng Ngài vẫn rộng lượng thứ tha
  nên chúng con thành tâm kính thờ.
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
    \override Lyrics.LyricSpace.minimum-distance = #1.2
    \override Score.BarNumber.break-visibility = ##(#f #f #f)
    \override Score.SpacingSpanner.uniform-stretching = ##t
  } 
}
