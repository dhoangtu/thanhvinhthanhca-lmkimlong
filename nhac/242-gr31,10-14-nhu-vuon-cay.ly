% Cài đặt chung\
\version "2.22.1"
\include "english.ly"

\header {
  title = \markup { \fontsize #1 "Như Vườn Cây" }
  composer = "Gr. 31,10-14"
  tagline = ##f
}

% Nhạc phiên khúc
nhacPhienKhucSop = \relative c'' {
  \partial 4 a8 a |
  d4. d8 |
  b! (a) fs8 g |
  a4 e8 g |
  g4. a8 |
  f ([g f]) e |
  d4 r8 d' |
  b! d d b |
  a8. a16 g8 f |
  e4 e8 f |
  a,4 a8 e' |
  f4 (e8) cs |
  d2 \bar "||"
  
  \set Staff.explicitKeySignatureVisibility = #end-of-line-invisible
  \set Staff.printKeyCancellation = ##f
  \key d \major
  fs4. g8 |
  a8. a16 \tuplet 3/2 { g8 a b } |
  b2 |
  g4. fs8 |
  e4 \tuplet 3/2 { e8 e g } |
  fs4 r8 d |
  b'4. b16 b |
  b8 g d' b |
  a4 r8 g |
  e4. e16 e|
  e8 a fs e |
  d4 \bar "|."
}

nhacPhienKhucAlto = \relative c' {
  r4 |
  R2*12
  
  \set Staff.explicitKeySignatureVisibility = #end-of-line-invisible
  \set Staff.printKeyCancellation = ##f
  \key d \major
  d4. e8 |
  fs8. fs16 \tuplet 3/2 { e8 fs d } |
  g2 |
  e4. d8 |
  cs4 \tuplet 3/2 { cs8 cs e } |
  d4 r8 d |
  g4. g16 g |
  g8 e fs g |
  fs4 r8 g |
  cs,4. cs16 cs |
  cs8 a b cs |
  d4
}

% Lời phiên khúc
loiPhienKhucSop = \lyrics {
  <<
    {
      \set stanza = "1."
      Muôn dân hỡi lắng nghe lời Thiên Chúa,
      Và loan đi các đảo xa vời:
      Đấng phân tán Ít -- ra -- en sẽ quy tụ lại,
      chăn dắt họ tựa chăn dắt đoàn chiên.
    }
    \new Lyrics {
	    \set associatedVoice = "beSop"
	    \set stanza = "2."
	    Đây Thiên Chúa cứu độ nhà Gia -- cóp
	    khỏi bao tay kẻ mạnh hơn nhiều,
	    Chúng vui sướng tới Si -- on hưởng bao ân lộc:
	    Đây lúa rượu cùng bê béo, cừu tơ.
    }
    \new Lyrics {
	    \set associatedVoice = "beSop"
	    \set stanza = "3."
	    Bao tang tóc Chúa đổi thành hoan hỉ
	    khỏi đau thương, chúng hưởng vui mừng.
	    Các tư tế sẽ no say thức ăn ngon lành,
	    Dân chúng được tặng ân phúc đầy dư.
    }
  >>
  \set stanza = "ĐK:"
  Lòng thỏa thuê như vườn cây tưới nước,
  Chúng không còn mòn mỏi héo hon.
  Ngày ấy các thiếu nữ nhảy múa reo vui,
  Trẻ già cùng mở hội hát ca tưng bừng.
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
    \override Lyrics.LyricSpace.minimum-distance = #1.8
    \override Score.BarNumber.break-visibility = ##(#f #f #f)
    \override Score.SpacingSpanner.uniform-stretching = ##t
  } 
}
