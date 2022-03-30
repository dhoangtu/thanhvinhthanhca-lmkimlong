% Cài đặt chung\
\version "2.22.1"
\include "english.ly"

\header {
  title = \markup { \fontsize #1 "Trời Đất Hãy Lắng Nghe" }
  composer = "Đnl. 32,1-12"
  tagline = ##f
}

% Nhạc phiên khúc
nhacPhienKhucSop = \relative c' {
  \partial 4 \tuplet 3/2 { d8 bf' a } |
  g4 \tuplet 3/2 { fs8 g \slashedGrace { a16 ( } g8) } |
  ef8. d16 \tuplet 3/2 { bf'8 bf a } |
  g4 \tuplet 3/2 { g8 c c } |
  d4 \tuplet 3/2 { ef8 ef c } |
  d8. c16 \tuplet 3/2 { bf8 c d } |
  d4 \tuplet 3/2 { bf8 c bf } |
  a8. d,16 \tuplet 3/2 { a'8 \slashedGrace { bf16 ( } g8) fs } |
  \partial 4 g4 \bar "||" \break
  
  \set Staff.explicitKeySignatureVisibility = #end-of-line-invisible
  \set Staff.printKeyCancellation = ##f
  \key g \major
  \partial 8 b16 b |
  b4 \tuplet 3/2 { a8 a g } |
  g16 (a \once \stemUp b4) a16 b |
  e,4 \tuplet 3/2 { g8 b g } |
  a4 r8 c16 c |
  c4 \tuplet 3/2 { c8 a c } |
  d4. c16 e |
  a,8. fs16 \tuplet 3/2 { d8 fs a } |
  g4 r8 \bar "||"
  
  d |
  d4. b'8 |
  b2 |
  r8 a16 g g8 g |
  c c16 a a8 b |
  d2 |
  c4. e8 |
  a,2 |
  r8 fs16 e g8 a |
  b d,16 d a'8 g |
  g2 \bar "|."
}

nhacPhienKhucAlto = \relative c'' {
  r4 |
  R2*7
  r4
  
  \set Staff.explicitKeySignatureVisibility = #end-of-line-invisible
  \set Staff.printKeyCancellation = ##f
  \key g \major
  g16 g |
  g4 \tuplet 3/2 { fs8 fs e } |
  e16 (fs g4) d16 d |
  c4 \tuplet 3/2 { e8 g e } |
  d4 r8 a'16 a |
  a4 \tuplet 3/2 { a8 e a } |
  b4. a16 g |
  fs8. d16 \tuplet 3/2 { c8 c c } |
  b4 r8
  
  d8 |
  d4. g8 |
  g2 |
  r8 fs16 f! e8 d |
  e a16 g fs8 e |
  fs2 |
  a4. g8 |
  fs2 |
  r8 d16 c b8 d |
  g b,16 b c8 c |
  b2
}

% Lời phiên khúc
loiPhienKhucSop = \lyrics {
  <<
    {
      \set stanza = "1."
      Trời hãy lắng tai này tôi sắp kể
      Và đất nghe cho tường lời tôi công bố
      Giáo huấn của tôi như giọt mưa thánh thót,
      Lời tôi khuyên dạy tựa sương móc nhỏ sa.
      Như mưa rơi, rơi trên nội cỏ
      Như nước về, về tưới đồng xanh:
      Đây tôi xin xưng tụng danh Chúa,
      Trời đất nào tôn thờ Thiên Chúa ta.
    }
    \new Lyrics {
	    \set associatedVoice = "beSop"
	    \set stanza = "2."
      \override Lyrics.LyricText.font-shape = #'italic
	    Này những đứa con đẹp xinh của Ngài
	    Lại thất đức vô nghì chạy theo gian ác,
	    Hỡi lũ xuẩn ngu sao đền ơn Chúa thế,
	    Là Cha sinh thành, Ngài luôn giữ gìn ngươi.
	    Hãy nhớ tới xa xưa vạn thuở
	    Mau gẫm lại từng thế hệ qua.
	    Xin cha ngươi hẳn người sẽ nói,
	    Bậc lão thành xin họ chỉ giáo cho.
    }
    \new Lyrics {
	    \set associatedVoice = "beSop"
	    \set stanza = "3."
	    Ngày Đấng Tối Cao vạch phân lãnh địa
	    Và khiến mỗi dân tộc về theo cương giới,
	    Chúa đã chọn riêng cơ nghiệp Gia -- cóp đó,
	    Ủ ấp giữ gìn Và lo dưỡng dục luôn.
	    Như chim bay, bay quanh vòng tổ
	    Giơ cánh bằng nhẹ dỗ đàn con,
	    Cõng lấy chúng trên mình đi tới,
	    Giục chúng hoài mau hãy tung cánh bay.
    }
  >>
  \set stanza = "ĐK:"
  Ngài là Núi Đá, công việc Ngài hoàn mỹ,
  lối đường Ngài ngay chính.
  Ngài tín thành không mảy may gian dối
  mà tuyệt đối công minh.
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
  \key bf \major \time 2/4
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
